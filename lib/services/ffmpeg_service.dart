import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/models/layout_option.dart';
import 'package:teslacam/models/processing_job.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

/// Service for handling video processing operations using FFmpeg
class FFmpegService {
  /// Generate a thumbnail for a video file
  Future<String?> generateThumbnail(VideoFile videoFile) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = '${tempDir.path}/${const Uuid().v4()}.jpg';
      
      // Extract a frame at 1 second mark
      final command = '-y -i "${videoFile.path}" -ss 00:00:01.000 -vframes 1 "$thumbnailPath"';
      
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      
      if (ReturnCode.isSuccess(returnCode)) {
        return thumbnailPath;
      } else {
        print('Error generating thumbnail: ${await session.getOutput()}');
        return null;
      }
    } catch (e) {
      print('Exception generating thumbnail: $e');
      return null;
    }
  }
  
  /// Extract video metadata (duration, width, height)
  Future<VideoFile> extractMetadata(VideoFile videoFile) async {
    try {
      final command = '-i "${videoFile.path}" -v quiet -print_format json -show_format -show_streams';
      
      final session = await FFmpegKit.execute(command);
      final output = await session.getOutput();
      final returnCode = await session.getReturnCode();
      
      if (ReturnCode.isSuccess(returnCode) && output != null) {
        // Parse JSON output to extract metadata
        // This is a simplified version - in a real app, you'd parse the JSON properly
        final durationMatch = RegExp(r'"duration":\s*"([^"]+)"').firstMatch(output);
        final widthMatch = RegExp(r'"width":\s*(\d+)').firstMatch(output);
        final heightMatch = RegExp(r'"height":\s*(\d+)').firstMatch(output);
        
        final durationStr = durationMatch?.group(1);
        final width = widthMatch?.group(1) != null ? int.parse(widthMatch!.group(1)!) : null;
        final height = heightMatch?.group(1) != null ? int.parse(heightMatch!.group(1)!) : null;
        
        int? durationMs;
        if (durationStr != null) {
          durationMs = (double.parse(durationStr) * 1000).round();
        }
        
        return videoFile.copyWith(
          durationMs: durationMs,
          width: width,
          height: height,
        );
      } else {
        print('Error extracting metadata: ${output ?? "Unknown error"}');
        return videoFile;
      }
    } catch (e) {
      print('Exception extracting metadata: $e');
      return videoFile;
    }
  }
  
  /// Process a job to merge multiple videos according to the specified layout
  Future<ProcessingJob> processJob(ProcessingJob job, 
      {Function(ProcessingJob)? onProgress}) async {
    try {
      final now = DateTime.now();
      var updatedJob = job.copyWith(
        status: ProcessingStatus.processing,
        startTime: now,
        updatedAt: now,
      );
      
      // Create output directory if it doesn't exist
      final documentsDir = await getApplicationDocumentsDirectory();
      final outputDir = Directory('${documentsDir.path}/merged_videos');
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }
      
      // Generate output file path
      final outputPath = '${outputDir.path}/${const Uuid().v4()}.mp4';
      updatedJob = updatedJob.copyWith(outputPath: outputPath);
      
      // Generate FFmpeg command based on layout
      var command = _generateCommand(updatedJob.inputVideos, 
          updatedJob.layoutOption, outputPath);
      
      if (command == null) {
        final failedJob = updatedJob.copyWith(
          status: ProcessingStatus.failed,
          errorMessage: 'Failed to generate FFmpeg command',
          endTime: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        onProgress?.call(failedJob);
        return failedJob;
      }

      // Add hardware acceleration flags
      command = '-hwaccel auto -hwaccel_output_format videotoolbox $command';

      // Create a completer to handle async completion
      final completer = Completer<ProcessingJob>();
      
      // Execute FFmpeg command
      final session = await FFmpegKit.executeAsync(
        command,
        (session) async {
          final returnCode = await session.getReturnCode();
          final output = await session.getOutput() ?? '';
          final logs = await session.getLogs();
          
          if (ReturnCode.isSuccess(returnCode)) {
            final completedJob = updatedJob.copyWith(
              status: ProcessingStatus.completed,
              progress: 100,
              endTime: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            onProgress?.call(completedJob);
            completer.complete(completedJob);
          } else {
            final errorMessage = output.isNotEmpty ? output : logs.map((log) => log.getMessage()).join('\n');
            final failedJob = updatedJob.copyWith(
              status: ProcessingStatus.failed,
              errorMessage: errorMessage,
              endTime: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            onProgress?.call(failedJob);
            completer.complete(failedJob);
          }
        },
        (log) {
          // Log FFmpeg output
          print('FFmpeg log: ${log.getMessage()}');
        },
        (statistics) {
          // Calculate progress based on frame count
          final frame = statistics.getVideoFrameNumber();
          if (frame <= 0) return;
          
          // Get total frames from first video
          final durationMs = updatedJob.inputVideos.first.durationMs;
          if (durationMs == null || durationMs <= 0) return;
          
          // Calculate total frames (36 fps from input videos)
          final totalFrames = (durationMs / 1000.0 * 36.0).round();
          if (totalFrames <= 0) return;
          
          // Calculate and update progress
          final progress = ((frame / totalFrames) * 100).round().clamp(0, 100);
          final progressJob = updatedJob.copyWith(
            progress: progress,
            updatedAt: DateTime.now(),
          );
          
          // Notify progress
          onProgress?.call(progressJob);
          updatedJob = progressJob;
        },
      );

      // Wait for completion and return final job state
      return completer.future;
    } catch (e) {
      print('Exception processing job: $e');
      final failedJob = job.copyWith(
        status: ProcessingStatus.failed,
        errorMessage: e.toString(),
        endTime: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      onProgress?.call(failedJob);
      return failedJob;
    }
  }
  
  /// Generate FFmpeg command for merging videos based on layout
  String? _generateCommand(List<VideoFile> videos, LayoutOption layout, String outputPath) {
    if (videos.isEmpty) return null;
    
    switch (layout.type) {
      case LayoutType.frontBack:
        return _generateFrontBackCommand(videos, outputPath);
      case LayoutType.frontSides:
        return _generateFrontSidesCommand(videos, outputPath);
      case LayoutType.backSides:
        return _generateBackSidesCommand(videos, outputPath);
      case LayoutType.allSides:
        return _generateAllSidesCommand(videos, outputPath);
      case LayoutType.pip:
        return _generatePipCommand(videos, outputPath);
    }
  }
  
  String _generateFrontBackCommand(List<VideoFile> videos, String outputPath) {
    if (videos.length < 2) return '';
    
    final inputs = videos.map((v) => '-i "${v.path}"').join(' ');
    
    // Front and back layout using vstack
    return '$inputs '
        '-t 60 ' // Limit duration to 60 seconds
        '-filter_complex '
        '"[0:v]scale=1920:-1[front];'
        '[1:v]scale=1920:-1[back];'
        '[front][back]vstack[v]" '
        '-map "[v]" -map 0:a? '
        '-c:v h264_videotoolbox -allow_sw 1 -realtime 1 '
        '-b:v 4M -maxrate 6M -bufsize 8M '
        '-c:a aac -b:a 128k -movflags +faststart '
        '"$outputPath"';
  }

  String _generateFrontSidesCommand(List<VideoFile> videos, String outputPath) {
    if (videos.length < 3) return '';
    
    final inputs = videos.map((v) => '-i "${v.path}"').join(' ');
    
    // Front with sides layout (videos touching each other)
    return '$inputs '
        '-t 60 ' // Limit duration to 60 seconds
        '-filter_complex '
        '"[0:v]scale=1920:-1[front];'
        '[1:v]scale=960:-1[left];'
        '[2:v]scale=960:-1[right];'
        '[left][right]hstack[bottom];'
        '[front][bottom]vstack[v]" '
        '-map "[v]" -map 0:a? '
        '-c:v h264_videotoolbox -allow_sw 1 -realtime 1 '
        '-b:v 4M -maxrate 6M -bufsize 8M '
        '-c:a aac -b:a 128k -movflags +faststart '
        '"$outputPath"';
  }

  String _generateBackSidesCommand(List<VideoFile> videos, String outputPath) {
    if (videos.length < 3) return '';
    
    // Find the videos by position
    final backVideo = videos.firstWhere((v) => v.position == 'back');
    final leftVideo = videos.firstWhere((v) => v.position == 'left');
    final rightVideo = videos.firstWhere((v) => v.position == 'right');
    
    // Back with sides layout using stacking filters
    return '-i "${backVideo.path}" -i "${leftVideo.path}" -i "${rightVideo.path}" '
        '-t 60 ' // Limit duration to 60 seconds
        '-filter_complex '
        '"[0:v]scale=1920:-1[back];'
        '[1:v]scale=960:-1[left];'
        '[2:v]scale=960:-1[right];'
        '[left][right]hstack[bottom];'
        '[back][bottom]vstack[v]" '
        '-map "[v]" -map 0:a? '
        '-c:v h264_videotoolbox -allow_sw 1 -realtime 1 '
        '-b:v 4M -maxrate 6M -bufsize 8M '
        '-c:a aac -b:a 128k -movflags +faststart '
        '"$outputPath"';
  }

  String _generateAllSidesCommand(List<VideoFile> videos, String outputPath) {
    if (videos.length < 4) return '';
    
    // Find videos by position
    final frontVideo = videos.firstWhere(
      (v) => v.position == 'front',
      orElse: () => videos.first,
    );
    
    final leftVideo = videos.firstWhere(
      (v) => v.position == 'left',
      orElse: () => videos.where((v) => v != frontVideo).first,
    );
    
    final backVideo = videos.firstWhere(
      (v) => v.position == 'back',
      orElse: () => videos.where((v) => v != frontVideo && v != leftVideo).first,
    );
    
    final rightVideo = videos.firstWhere(
      (v) => v.position == 'right',
      orElse: () => videos.where((v) => 
        v != frontVideo && v != leftVideo && v != backVideo
      ).first,
    );
    
    // All sides layout using stacking filters
    return '-i "${frontVideo.path}" -i "${leftVideo.path}" -i "${backVideo.path}" -i "${rightVideo.path}" '
        '-t 60 ' // Limit duration to 60 seconds
        '-filter_complex '
        '"[0:v]scale=1920:-1[front];'
        '[1:v]scale=640:-1[left];'
        '[2:v]scale=640:-1[back];'
        '[3:v]scale=640:-1[right];'
        '[left][back][right]hstack=3[bottom];'
        '[front][bottom]vstack[v]" '
        '-map "[v]" -map 0:a? '
        '-c:v h264_videotoolbox -allow_sw 1 -realtime 1 '
        '-b:v 4M -maxrate 6M -bufsize 8M '
        '-c:a aac -b:a 128k -movflags +faststart '
        '"$outputPath"';
  }

  String _generatePipCommand(List<VideoFile> videos, String outputPath) {
    if (videos.length < 2) return '';
    
    final inputs = videos.map((v) => '-i "${v.path}"').join(' ');
    
    // Picture-in-Picture layout (main video with small overlay)
    return '$inputs '
        '-t 60 ' // Limit duration to 60 seconds
        '-filter_complex '
        '"[0:v]scale=1920:1080:force_original_aspect_ratio=decrease,setpts=PTS-STARTPTS[main];'
        '[1:v]scale=384:216:force_original_aspect_ratio=decrease,setpts=PTS-STARTPTS[pip];'
        'color=c=black:s=1920x1080[base];'
        '[base][main]overlay=0:0[temp];'
        '[temp][pip]overlay=main_w-overlay_w-32:main_h-overlay_h-32:format=rgb[v]" '
        '-map "[v]" -map 0:a? '
        '-c:v h264_videotoolbox -allow_sw 1 -realtime 1 '
        '-b:v 4M -maxrate 6M -bufsize 8M '
        '-c:a aac -b:a 128k -movflags +faststart '
        '"$outputPath"';
  }
  
  /// Cancel a processing job
  Future<bool> cancelJob(ProcessingJob job) async {
    try {
      // Find and cancel the FFmpeg session
      final sessions = await FFmpegKit.listSessions();
      for (final session in sessions) {
        await session.cancel();
            }
      
      return true;
    } catch (e) {
      print('Error cancelling job: $e');
      return false;
    }
  }

  /// Save a video to the device's gallery
  Future<bool> saveVideoToGallery(String videoPath) async {
    try {
      final file = File(videoPath);
      if (!await file.exists()) {
        print('Video file does not exist: $videoPath');
        return false;
      }

      final result = await ImageGallerySaver.saveFile(
        videoPath,
        name: 'TeslaCam_${DateTime.now().millisecondsSinceEpoch}',
      );

      return result['isSuccess'] ?? false;
    } catch (e) {
      print('Error saving video to gallery: $e');
      return false;
    }
  }
} 