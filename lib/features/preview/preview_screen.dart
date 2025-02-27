import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/models/layout_option.dart';
import 'package:teslacam/providers/video_providers.dart';
import 'package:teslacam/providers/layout_providers.dart';

/// Screen for previewing the merged video layout
class PreviewScreen extends ConsumerStatefulWidget {
  /// Creates a new [PreviewScreen]
  const PreviewScreen({super.key});

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  final Map<String, VideoPlayerController> _controllers = {};
  bool _isPlaying = false;
  
  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }
  
  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
  Future<void> _initializeControllers() async {
    final selectedVideos = ref.read(selectedVideosProvider);
    final selectedGroup = ref.read(selectedGroupProvider);
    final groupVideos = selectedVideos
        .where((video) => video.groupId == selectedGroup)
        .toList();
    
    for (final video in groupVideos) {
      final controller = VideoPlayerController.file(File(video.path));
      _controllers[video.id] = controller;
      
      await controller.initialize();
      
      // Ensure all videos are at the same position
      if (_controllers.length > 1) {
        final firstController = _controllers.values.first;
        await controller.seekTo(firstController.value.position);
      }
    }
    
    // Force a rebuild after controllers are initialized
    if (mounted) {
      setState(() {});
    }
  }
  
  void _playPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      
      for (final controller in _controllers.values) {
        if (_isPlaying) {
          controller.play();
        } else {
          controller.pause();
        }
      }
    });
  }
  
  Future<void> _seekTo(Duration position) async {
    for (final controller in _controllers.values) {
      await controller.seekTo(position);
    }
    
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedVideos = ref.watch(selectedVideosProvider);
    final selectedGroup = ref.watch(selectedGroupProvider);
    final groupVideos = selectedVideos
        .where((video) => video.groupId == selectedGroup)
        .toList();
    final selectedLayout = ref.watch(selectedLayoutProvider);
    
    final isInitialized = _controllers.isNotEmpty && 
        _controllers.values.every((controller) => controller.value.isInitialized);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Layout info
          _LayoutInfo(layout: selectedLayout),
          
          // Video preview
          Expanded(
            child: isInitialized
                ? _buildVideoPreview(groupVideos, selectedLayout)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          
          // Video controls
          if (isInitialized)
            _VideoControls(
              controllers: _controllers.values.toList(),
              isPlaying: _isPlaying,
              onPlayPause: _playPause,
              onSeek: _seekTo,
            ),
          
          // Bottom action bar
          _BottomActionBar(
            onBack: () => context.go('/select-layout'),
            onContinue: () => context.go('/processing'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVideoPreview(List<VideoFile> videos, LayoutOption layout) {
    switch (layout.type) {
      case LayoutType.frontBack:
        return _buildGridPreview(videos);
      case LayoutType.frontSides:
      case LayoutType.backSides:
        return _buildHorizontalSplitPreview(videos);
      case LayoutType.allSides:
        return _buildTeslaPreview(videos);
      case LayoutType.pip:
        return _buildPipPreview(videos);
    }
  }
  
  Widget _buildGridPreview(List<VideoFile> videos) {
    if (videos.length == 4) {
      // 2x2 grid
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 16 / 9,
        children: videos.map((video) => _buildVideoPlayer(video)).toList(),
      );
    } else if (videos.length == 2) {
      // Front and back vertical stack
      return Column(
        children: videos.map((video) => 
          Expanded(child: _buildVideoPlayer(video))
        ).toList(),
      );
    } else {
      // Single video
      return _buildVideoPlayer(videos.first);
    }
  }
  
  Widget _buildHorizontalSplitPreview(List<VideoFile> videos) {
    if (videos.length < 2) return _buildVideoPlayer(videos.first);
    
    final selectedLayout = ref.watch(selectedLayoutProvider);
    final isBackSides = selectedLayout.type == LayoutType.backSides;
    
    // Find the main camera (back for backSides, front for frontSides)
    final mainVideo = videos.firstWhere(
      (v) => v.position == (isBackSides ? 'back' : 'front'),
      orElse: () => videos.first,
    );
    
    // Find side cameras
    final leftVideo = videos.firstWhere(
      (v) => v.position == 'left',
      orElse: () => videos.where((v) => v != mainVideo).first,
    );
    final rightVideo = videos.firstWhere(
      (v) => v.position == 'right',
      orElse: () => videos.where((v) => v != mainVideo && v != leftVideo).first,
    );
    
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Main camera (70% height)
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.all(2),
              child: _buildVideoPlayer(mainVideo),
            ),
          ),
          // Left and right cameras (30% height)
          if (videos.length >= 3)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Left camera
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      child: _buildVideoPlayer(leftVideo),
                    ),
                  ),
                  // Right camera
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      child: _buildVideoPlayer(rightVideo),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildTeslaPreview(List<VideoFile> videos) {
    if (videos.length < 4) return _buildVideoPlayer(videos.first);
    
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
    
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Front camera (top)
          Expanded(
            flex: 7, // 70% of height
            child: _buildVideoPlayer(frontVideo),
          ),
          // Bottom row (left, back, right)
          Expanded(
            flex: 3, // 30% of height
            child: Row(
              children: [
                // Left camera
                Expanded(
                  flex: 33,
                  child: _buildVideoPlayer(leftVideo),
                ),
                // Back camera
                Expanded(
                  flex: 34,
                  child: _buildVideoPlayer(backVideo),
                ),
                // Right camera
                Expanded(
                  flex: 33,
                  child: _buildVideoPlayer(rightVideo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPipPreview(List<VideoFile> videos) {
    if (videos.length < 2) return _buildVideoPlayer(videos.first);
    
    return Stack(
      children: [
        // Main video
        SizedBox.expand(
          child: _buildVideoPlayer(videos.first),
        ),
        
        // PiP video
        Positioned(
          right: 16,
          bottom: 16,
          width: 120,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(128),
                  blurRadius: 8,
                ),
              ],
            ),
            child: _buildVideoPlayer(videos[1]),
          ),
        ),
      ],
    );
  }
  
  Widget _buildVideoPlayer(VideoFile video) {
    final controller = _controllers[video.id];
    
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Video player
          VideoPlayer(controller),
          
          // Position label if available
          if (video.position != null)
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(179),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  video.position!.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget displaying information about the selected layout
class _LayoutInfo extends StatelessWidget {
  /// The selected layout
  final LayoutOption layout;

  /// Creates a new [_LayoutInfo]
  const _LayoutInfo({required this.layout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getLayoutIcon(layout.type),
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 8),
          Text(
            layout.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          // Layout type badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _getLayoutName(layout.type),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getLayoutIcon(LayoutType type) {
    switch (type) {
      case LayoutType.frontBack:
        return Icons.grid_view;
      case LayoutType.frontSides:
      case LayoutType.backSides:
        return Icons.splitscreen;
      case LayoutType.allSides:
        return Icons.dashboard;
      case LayoutType.pip:
        return Icons.picture_in_picture;
    }
  }
  
  String _getLayoutName(LayoutType type) {
    switch (type) {
      case LayoutType.frontBack:
        return 'Front & Back';
      case LayoutType.frontSides:
        return 'Front with Sides';
      case LayoutType.backSides:
        return 'Back with Sides';
      case LayoutType.allSides:
        return 'All Cameras';
      case LayoutType.pip:
        return 'Picture-in-Picture';
    }
  }
}

/// Widget for video playback controls
class _VideoControls extends StatelessWidget {
  /// The video controllers
  final List<VideoPlayerController> controllers;
  
  /// Whether the video is currently playing
  final bool isPlaying;
  
  /// Callback for play/pause
  final VoidCallback onPlayPause;
  
  /// Callback for seeking
  final Function(Duration) onSeek;

  /// Creates a new [_VideoControls]
  const _VideoControls({
    required this.controllers,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    if (controllers.isEmpty) return const SizedBox.shrink();
    
    final controller = controllers.first;
    final duration = controller.value.duration;
    final position = controller.value.position;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.black,
      child: Column(
        children: [
          // Progress slider
          Slider(
            value: position.inMilliseconds.toDouble(),
            min: 0,
            max: duration.inMilliseconds.toDouble(),
            onChanged: (value) {
              onSeek(Duration(milliseconds: value.toInt()));
            },
            activeColor: Colors.red,
            inactiveColor: Colors.grey.shade700,
          ),
          
          // Time and controls
          Row(
            children: [
              // Current position
              Text(
                _formatDuration(position),
                style: const TextStyle(color: Colors.white),
              ),
              
              const SizedBox(width: 8),
              
              // Duration
              Text(
                '/ ${_formatDuration(duration)}',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              
              const Spacer(),
              
              // Play/pause button
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: onPlayPause,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

/// Widget for displaying the bottom action bar
class _BottomActionBar extends StatelessWidget {
  /// Callback for going back
  final VoidCallback onBack;
  
  /// Callback for continuing to the next screen
  final VoidCallback onContinue;

  /// Creates a new [_BottomActionBar]
  const _BottomActionBar({
    required this.onBack,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
          ),
          const Spacer(),
          // Continue button
          ElevatedButton.icon(
            onPressed: onContinue,
            icon: const Icon(Icons.merge_type),
            label: const Text('Merge Videos'),
          ),
        ],
      ),
    );
  }
} 