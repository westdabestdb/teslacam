import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/services/ffmpeg_service.dart';

part 'video_providers.g.dart';

/// Provider for the FFmpeg service
@riverpod
FFmpegService ffmpegService(FfmpegServiceRef ref) {
  return FFmpegService();
}

/// Provider for selected videos
@riverpod
class SelectedVideos extends _$SelectedVideos {
  @override
  List<VideoFile> build() {
    return [];
  }
  
  /// Add a video to the selection
  void addVideo(VideoFile video) {
    state = [...state, video];
  }
  
  /// Remove a video from the selection
  void removeVideo(String videoId) {
    state = state.where((video) => video.id != videoId).toList();
  }
  
  /// Clear all selected videos
  void clearVideos() {
    state = [];
  }
  
  /// Update a video in the selection
  void updateVideo(VideoFile updatedVideo) {
    state = state.map((video) => 
      video.id == updatedVideo.id ? updatedVideo : video
    ).toList();
  }
  
  /// Set position for a video
  void setVideoPosition(String videoId, String position) {
    state = state.map((video) => 
      video.id == videoId ? video.copyWith(position: position) : video
    ).toList();
  }
  
  /// Set group ID for a video
  void setVideoGroup(String videoId, String groupId) {
    state = state.map((video) => 
      video.id == videoId ? video.copyWith(groupId: groupId) : video
    ).toList();
  }
  
  /// Get videos by group ID
  List<VideoFile> getVideosByGroup(String groupId) {
    return state.where((video) => video.groupId == groupId).toList();
  }
  
  /// Get videos by position
  VideoFile? getVideoByPosition(String position, {String? groupId}) {
    final videos = groupId != null 
        ? state.where((video) => video.groupId == groupId).toList()
        : state;
    
    final index = videos.indexWhere((video) => video.position == position);
    return index != -1 ? videos[index] : null;
  }
}

/// Provider for video metadata loading
@riverpod
Future<VideoFile> videoMetadata(
  VideoMetadataRef ref,
  VideoFile video,
) async {
  // Check if metadata is already loaded
  if (video.durationMs != null && video.width != null && video.height != null) {
    // If thumbnail exists or was already attempted, return as is
    if (video.thumbnailPath != null || video.thumbnailAttempted == true) {
      return video;
    }
  }

  // Extract metadata
  final ffmpegService = ref.watch(ffmpegServiceProvider);
  var updatedVideo = await ffmpegService.extractMetadata(video);
  
  // Generate thumbnail if not already generated
  if (updatedVideo.thumbnailPath == null && !updatedVideo.thumbnailAttempted) {
    final thumbnailPath = await ffmpegService.generateThumbnail(updatedVideo);
    updatedVideo = updatedVideo.copyWith(
      thumbnailPath: thumbnailPath,
      thumbnailAttempted: true,
    );
  }
  
  // Update the video in the selected videos list
  ref.read(selectedVideosProvider.notifier).updateVideo(updatedVideo);
  return updatedVideo;
}

/// Provider for video groups
@riverpod
class VideoGroups extends _$VideoGroups {
  @override
  List<String> build() {
    return ['default'];
  }
  
  /// Add a new group
  void addGroup(String groupId) {
    if (!state.contains(groupId)) {
      state = [...state, groupId];
    }
  }
  
  /// Remove a group
  void removeGroup(String groupId) {
    if (groupId != 'default') {
      state = state.where((group) => group != groupId).toList();
    }
  }
}

/// Provider for the currently selected group
@riverpod
class SelectedGroup extends _$SelectedGroup {
  @override
  String build() {
    return 'default';
  }
  
  /// Set the selected group
  void setGroup(String groupId) {
    state = groupId;
  }
} 