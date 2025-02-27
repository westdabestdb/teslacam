import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/models/layout_option.dart';
import 'package:teslacam/providers/video_providers.dart';
import 'package:teslacam/providers/layout_providers.dart';

/// Screen for selecting videos to merge
class VideoSelectionScreen extends ConsumerWidget {
  /// Creates a new [VideoSelectionScreen]
  const VideoSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedLayout = ref.watch(selectedLayoutProvider);
    final selectedVideos = ref.watch(selectedVideosProvider);
    final selectedGroup = ref.watch(selectedGroupProvider);
    final groupVideos = selectedVideos
        .where((video) => video.groupId == selectedGroup)
        .toList();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7), // iOS background color
      appBar: AppBar(
        title: const Text('Select Videos'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F7),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Layout info card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF007AFF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getLayoutIcon(selectedLayout.type),
                        color: const Color(0xFF007AFF),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedLayout.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedLayout.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => context.go('/select-layout'),
                      child: const Text('Change'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF007AFF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Video list or empty state
          Expanded(
            child: groupVideos.isEmpty
                ? _buildEmptyState(context, selectedLayout)
                : _buildVideoList(context, groupVideos, selectedLayout),
          ),
          
          // Bottom action bar
          _buildBottomActionBar(context, groupVideos, selectedLayout),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context, LayoutOption layout) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.videocam_off_rounded,
              size: 40,
              color: Color(0xFF007AFF),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Videos Selected',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add up to ${layout.videoCount} videos for ${layout.name.toLowerCase()}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, _) => FilledButton(
              onPressed: () => _pickVideos(context, ref, layout),
              child: const Text('Add Videos'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildVideoList(
    BuildContext context,
    List<VideoFile> videos,
    LayoutOption layout,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return _VideoCard(video: video);
      },
    );
  }
  
  Widget _buildBottomActionBar(
    BuildContext context,
    List<VideoFile> videos,
    LayoutOption layout,
  ) {
    final canAddMore = videos.length < layout.videoCount;
    final hasMinimumVideos = videos.length >= layout.minVideoCount;
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA), // iOS divider color
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (canAddMore)
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) => OutlinedButton(
                    onPressed: () => _pickVideos(context, ref, layout),
                    child: const Text('Add Videos'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF007AFF),
                      side: const BorderSide(color: Color(0xFF007AFF)),
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            if (canAddMore)
              const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: hasMinimumVideos ? () => context.go('/preview') : null,
                child: const Text('Continue'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _pickVideos(
    BuildContext context,
    WidgetRef ref,
    LayoutOption layout,
  ) async {
    final selectedVideos = ref.read(selectedVideosProvider);
    final selectedGroup = ref.read(selectedGroupProvider);
    final groupVideos = selectedVideos
        .where((video) => video.groupId == selectedGroup)
        .toList();
    
    if (groupVideos.length >= layout.videoCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum ${layout.videoCount} videos allowed for this layout',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );
    
    if (result != null) {
      final files = result.files
          .where((file) => file.path != null)
          .map((file) {
            // Detect position from filename
            String? position;
            final name = file.name.toLowerCase();
            
            if (name.contains('front')) {
              position = 'front';
            } else if (name.contains('back')) {
              position = 'back';
            } else if (name.contains('left')) {
              position = 'left';
            } else if (name.contains('right')) {
              position = 'right';
            }
            
            final video = VideoFile(
              id: const Uuid().v4(),
              path: file.path!,
              name: file.name,
              size: file.size,
              createdAt: DateTime.now(),
              groupId: selectedGroup,
              position: position,
            );

            // Extract metadata and generate thumbnail
            ref.read(videoMetadataProvider(video));
            
            return video;
          })
          .toList();
      
      // Limit the number of videos based on layout
      final availableSlots = layout.videoCount - groupVideos.length;
      final filesToAdd = files.take(availableSlots).toList();
      
      if (filesToAdd.length < files.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Only added ${filesToAdd.length} videos. Maximum ${layout.videoCount} videos allowed.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
      
      final notifier = ref.read(selectedVideosProvider.notifier);
      for (final file in filesToAdd) {
        notifier.addVideo(file);
      }
    }
  }
  
  IconData _getLayoutIcon(LayoutType type) {
    switch (type) {
      case LayoutType.frontBack:
        return Icons.grid_view_rounded;
      case LayoutType.frontSides:
      case LayoutType.backSides:
        return Icons.splitscreen_rounded;
      case LayoutType.allSides:
        return Icons.dashboard_rounded;
      case LayoutType.pip:
        return Icons.picture_in_picture_rounded;
    }
  }
}

/// Widget for displaying a video card
class _VideoCard extends ConsumerWidget {
  /// The video to display
  final VideoFile video;
  
  /// Creates a new [_VideoCard]
  const _VideoCard({required this.video});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metadata = ref.watch(videoMetadataProvider(video));
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video thumbnail
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Placeholder or thumbnail
                metadata.when(
                  data: (updatedVideo) => updatedVideo.thumbnailPath != null
                      ? Image.file(
                          File(updatedVideo.thumbnailPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholder();
                          },
                        )
                      : _buildPlaceholder(),
                  loading: () => _buildLoadingPlaceholder(),
                  error: (_, __) => _buildPlaceholder(),
                ),
                
                // Position indicator (if set)
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
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getPositionIcon(video.position!),
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            video.position!.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Video info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                metadata.when(
                  data: (updatedVideo) => Row(
                    children: [
                      Icon(
                        Icons.sd_storage_rounded,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatFileSize(updatedVideo.size),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (updatedVideo.durationMs != null) ...[
                        const SizedBox(width: 16),
                        Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(Duration(milliseconds: updatedVideo.durationMs!)),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  loading: () => Row(
                    children: [
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Loading metadata...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  error: (_, __) => Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatFileSize(video.size),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _showPositionDialog(context, ref),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swap_horiz_rounded, size: 16),
                        SizedBox(width: 4),
                        Text('Change Position'),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF007AFF),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref.read(selectedVideosProvider.notifier)
                          .removeVideo(video.id);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_rounded, size: 16),
                        SizedBox(width: 4),
                        Text('Remove'),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFFF3B30), // iOS red
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFF2F2F7),
      child: Center(
        child: Icon(
          Icons.videocam_rounded,
          size: 40,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: const Color(0xFFF2F2F7),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _showPositionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: _VideoPositionAssignment(
          video: video,
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
  
  IconData _getPositionIcon(String position) {
    switch (position) {
      case 'front':
        return Icons.arrow_upward_rounded;
      case 'back':
        return Icons.arrow_downward_rounded;
      case 'left':
        return Icons.arrow_back_rounded;
      case 'right':
        return Icons.arrow_forward_rounded;
      default:
        return Icons.videocam_rounded;
    }
  }
}

/// Widget for assigning positions to videos
class _VideoPositionAssignment extends ConsumerWidget {
  final VideoFile video;
  final VoidCallback onClose;

  const _VideoPositionAssignment({
    required this.video,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVideos = ref.watch(selectedVideosProvider);
    final selectedGroup = ref.watch(selectedGroupProvider);
    final groupVideos = selectedVideos
        .where((video) => video.groupId == selectedGroup)
        .toList();

    return Container(
      width: 600,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Assign Video Position',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Layout preview
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _LayoutPreview(
              video: video,
              groupVideos: groupVideos,
            ),
          ),

          const SizedBox(height: 24),

          // Position options
          Row(
            children: [
              Expanded(
                child: _PositionOption(
                  position: 'front',
                  video: video,
                  groupVideos: groupVideos,
                  icon: Icons.arrow_upward,
                  label: 'Front Camera',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PositionOption(
                  position: 'back',
                  video: video,
                  groupVideos: groupVideos,
                  icon: Icons.arrow_downward,
                  label: 'Back Camera',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PositionOption(
                  position: 'left',
                  video: video,
                  groupVideos: groupVideos,
                  icon: Icons.arrow_back,
                  label: 'Left Camera',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PositionOption(
                  position: 'right',
                  video: video,
                  groupVideos: groupVideos,
                  icon: Icons.arrow_forward,
                  label: 'Right Camera',
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Help text
          Text(
            'Drag and drop the video to a position or tap a position to assign it.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying the layout preview
class _LayoutPreview extends ConsumerWidget {
  final VideoFile video;
  final List<VideoFile> groupVideos;

  const _LayoutPreview({
    required this.video,
    required this.groupVideos,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Main view (front)
          Positioned.fill(
            bottom: 120, // Leave space for bottom row
            child: _PositionDropTarget(
              position: 'front',
              video: video,
              groupVideos: groupVideos,
              child: _VideoPreview(
                video: _getVideoForPosition('front'),
                label: 'Front',
                flex: 2,
              ),
            ),
          ),
          // Bottom row (left, back, right)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: _PositionDropTarget(
                    position: 'left',
                    video: video,
                    groupVideos: groupVideos,
                    child: _VideoPreview(
                      video: _getVideoForPosition('left'),
                      label: 'Left',
                    ),
                  ),
                ),
                Expanded(
                  child: _PositionDropTarget(
                    position: 'back',
                    video: video,
                    groupVideos: groupVideos,
                    child: _VideoPreview(
                      video: _getVideoForPosition('back'),
                      label: 'Back',
                    ),
                  ),
                ),
                Expanded(
                  child: _PositionDropTarget(
                    position: 'right',
                    video: video,
                    groupVideos: groupVideos,
                    child: _VideoPreview(
                      video: _getVideoForPosition('right'),
                      label: 'Right',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  VideoFile? _getVideoForPosition(String position) {
    // First check if any video in the group has this position
    for (final v in groupVideos) {
      if (v.position == position) {
        return v;
      }
    }
    
    // If no video in the group has this position,
    // check if it's the current video's position
    if (video.position == position) {
      return video;
    }
    
    // No video found for this position
    return null;
  }
}

/// Widget for displaying a video preview
class _VideoPreview extends StatelessWidget {
  final VideoFile? video;
  final String label;
  final int flex;

  const _VideoPreview({
    required this.video,
    required this.label,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final aspectRatio = width / height;

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey.shade800,
              width: 1,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (video != null && video!.thumbnailPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Image.file(
                      File(video!.thumbnailPath!),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder();
                      },
                    ),
                  ),
                )
              else
                _buildPlaceholder(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(51),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withAlpha(51),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    video != null ? video!.name : label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade900,
      child: const Center(
        child: Icon(
          Icons.videocam_off,
          size: 24,
          color: Colors.white24,
        ),
      ),
    );
  }
}

/// Widget for a position drop target
class _PositionDropTarget extends ConsumerWidget {
  final String position;
  final VideoFile video;
  final List<VideoFile> groupVideos;
  final Widget child;

  const _PositionDropTarget({
    required this.position,
    required this.video,
    required this.groupVideos,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<VideoFile>(
      onWillAcceptWithDetails: (draggedVideo) {
        // Accept if it's the current video or no video is assigned to this position
        return draggedVideo == video || 
            !groupVideos.any((v) => v.position == position);
      },
      onAcceptWithDetails: (draggedVideo) {
        // Update the video's position
        ref.read(selectedVideosProvider.notifier)
            .setVideoPosition(draggedVideo.data.id, position);
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<VideoFile>(
          data: video,
          feedback: SizedBox(
            width: 120,
            height: 80,
            child: child,
          ),
          childWhenDragging: Opacity(
            opacity: 0.5,
            child: child,
          ),
          child: child,
        );
      },
    );
  }
}

/// Widget for a position option button
class _PositionOption extends ConsumerWidget {
  final String position;
  final VideoFile video;
  final List<VideoFile> groupVideos;
  final IconData icon;
  final String label;

  const _PositionOption({
    required this.position,
    required this.video,
    required this.groupVideos,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAssigned = groupVideos.any((v) => v.position == position);
    final isCurrentVideo = video.position == position;

    return OutlinedButton(
      onPressed: isAssigned && !isCurrentVideo ? null : () {
        ref.read(selectedVideosProvider.notifier)
            .setVideoPosition(video.id, position);
        Navigator.of(context).pop();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isCurrentVideo ? Colors.red.shade50 : null,
        foregroundColor: isCurrentVideo ? Colors.red : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Helper function to format file size
String _formatFileSize(int sizeInBytes) {
  if (sizeInBytes < 1024) {
    return '$sizeInBytes B';
  } else if (sizeInBytes < 1024 * 1024) {
    return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
  } else if (sizeInBytes < 1024 * 1024 * 1024) {
    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  } else {
    return '${(sizeInBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// Helper function to format duration
String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

/// Widget for selecting a video group
class _GroupSelector extends ConsumerWidget {
  /// The currently selected group
  final String selectedGroup;
  
  /// Creates a new [_GroupSelector]
  const _GroupSelector({required this.selectedGroup});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(videoGroupsProvider);
    
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: groups.length + 1, // +1 for the "Add Group" button
        itemBuilder: (context, index) {
          if (index == groups.length) {
            // "Add Group" button
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  onPressed: () => _showAddGroupDialog(context, ref),
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Add Group',
                ),
              ),
            );
          }
          
          final group = groups[index];
          final isSelected = group == selectedGroup;
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(group),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedGroupProvider.notifier).setGroup(group);
                }
              },
              backgroundColor: Colors.grey.shade200,
              selectedColor: Colors.red.shade100,
              labelStyle: TextStyle(
                color: isSelected ? Colors.red : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
  
  void _showAddGroupDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Group'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Group Name',
            hintText: 'Enter a name for the new group',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                ref.read(videoGroupsProvider.notifier).addGroup(name);
                ref.read(selectedGroupProvider.notifier).setGroup(name);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

Widget _buildGenericPreview(LayoutOption layout) {
  switch (layout.type) {
    case LayoutType.frontBack:
      return _buildGridPreview();
    case LayoutType.frontSides:
    case LayoutType.backSides:
      return _buildSplitPreview();
    case LayoutType.allSides:
      return _buildTeslaPreview();
    case LayoutType.pip:
      return _buildPipPreview();
  }
  // Default case
  return _buildGridPreview();
}

Widget _buildGridPreview() {
  return Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: _buildPlaceholderVideo('Front', 1),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildPlaceholderVideo('Back', 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: _buildPlaceholderVideo('Left', 3),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildPlaceholderVideo('Right', 4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSplitPreview() {
  return Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Expanded(
          flex: 7,
          child: _buildPlaceholderVideo('Front', 1),
        ),
        const SizedBox(height: 4),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: _buildPlaceholderVideo('Left', 2),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildPlaceholderVideo('Right', 3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTeslaPreview() {
  return Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Expanded(
          flex: 7,
          child: _buildPlaceholderVideo('Front', 1),
        ),
        const SizedBox(height: 4),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: _buildPlaceholderVideo('Left', 2),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 34,
                child: _buildPlaceholderVideo('Back', 3),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildPlaceholderVideo('Right', 4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipPreview() {
  return Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.all(8),
    child: Stack(
      children: [
        _buildPlaceholderVideo('Main', 1),
        Positioned(
          right: 12,
          bottom: 12,
          width: 80,
          height: 45,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'PiP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPlaceholderVideo(String label, int number) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Stack(
      children: [
        // Camera icon
        Center(
          child: Icon(
            Icons.videocam_rounded,
            color: Colors.grey.shade600,
            size: 24,
          ),
        ),
        // Position label
        Positioned(
          left: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayoutPreview(BuildContext context, LayoutOption layout) {
  // If there's a preview image, use it
  if (layout.thumbnailPath != null) {
    return Image.file(
      File(layout.thumbnailPath!),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildGenericPreview(layout);
      },
    );
  }
  
  // Otherwise, build a generic preview based on layout type
  return _buildGenericPreview(layout);
} 