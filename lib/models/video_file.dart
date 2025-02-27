import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'video_file.freezed.dart';
part 'video_file.g.dart';

/// Represents a video file in the application
@freezed
class VideoFile with _$VideoFile {
  const VideoFile._();

  const factory VideoFile({
    /// Unique identifier for the video file
    required String id,
    
    /// Path to the video file on the device
    required String path,
    
    /// Name of the video file
    required String name,
    
    /// Size of the video file in bytes
    required int size,
    
    /// Duration of the video in milliseconds
    int? durationMs,
    
    /// Width of the video in pixels
    int? width,
    
    /// Height of the video in pixels
    int? height,
    
    /// Path to the thumbnail image for this video
    String? thumbnailPath,
    
    /// Whether thumbnail generation has been attempted
    @Default(false) bool thumbnailAttempted,
    
    /// Position in the layout (e.g., "front", "back", "left", "right")
    String? position,
    
    /// Group identifier for related videos
    String? groupId,
    
    /// Creation timestamp
    required DateTime createdAt,
  }) = _VideoFile;

  /// Creates a VideoFile from a file path
  factory VideoFile.fromPath(String path, String name, int size) {
    return VideoFile(
      id: const Uuid().v4(),
      path: path,
      name: name,
      size: size,
      createdAt: DateTime.now(),
    );
  }

  /// Converts a VideoFile to JSON
  factory VideoFile.fromJson(Map<String, dynamic> json) => 
      _$VideoFileFromJson(json);
} 