import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:teslacam/models/processing_job.dart';
import 'package:teslacam/providers/video_providers.dart';
import 'package:teslacam/providers/layout_providers.dart';
import 'package:teslacam/providers/processing_providers.dart';

/// Screen for processing and merging videos
class ProcessingScreen extends ConsumerStatefulWidget {
  /// Creates a new [ProcessingScreen]
  const ProcessingScreen({super.key});

  @override
  ConsumerState<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends ConsumerState<ProcessingScreen> {
  VideoPlayerController? _outputController;
  bool _isPlaying = false;
  final bool _hasStartedProcessing = false;
  
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void _navigateTo(String route) {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.go(route);
    });
  }
  
  @override
  void initState() {
    super.initState();
    Future(() => _startProcessing());
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  
  @override
  void dispose() {
    _outputController?.dispose();
    super.dispose();
  }
  
  Future<void> _startProcessing() async {
    if (!mounted) return;

    try {
      final selectedVideos = ref.read(selectedVideosProvider);
      final selectedGroup = ref.read(selectedGroupProvider);
      final groupVideos = selectedVideos
          .where((video) => video.groupId == selectedGroup)
          .toList();
      final selectedLayout = ref.read(selectedLayoutProvider);
      
      if (groupVideos.isEmpty) {
        _showErrorSnackBar('No videos selected for processing');
        _navigateTo('/select-videos');
        return;
      }

      // Start processing using the processing state provider
      ref.read(processingStateProvider.notifier)
          .startProcessing(groupVideos, selectedLayout);
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('Error processing videos: $e');
      _navigateTo('/');
    }
  }
  
  Future<void> _initializeOutputVideo(String path) async {
    _outputController = VideoPlayerController.file(File(path));
    await _outputController!.initialize();
    setState(() {});
  }
  
  void _playPause() {
    if (_outputController == null) return;
    
    setState(() {
      _isPlaying = !_isPlaying;
      
      if (_isPlaying) {
        _outputController!.play();
      } else {
        _outputController!.pause();
      }
    });
  }
  
  Future<void> _saveVideo(String path) async {
    try {
      final ffmpegService = ref.read(ffmpegServiceProvider);
      final success = await ffmpegService.saveVideoToGallery(path);
      
      if (!mounted) return;
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video saved to gallery successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save video'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving video: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final processingState = ref.watch(processingStateProvider);
    final activeJob = ref.watch(activeJobProvider);
    final completedJobs = ref.watch(processingJobsProvider)
        .where((job) => job.isCompleted)
        .toList();
    
    return processingState.when(
      data: (job) {
        // Initialize output video if job completed and controller not initialized
        if (job != null && 
            job.isCompleted && 
            job.outputPath != null && 
            _outputController == null) {
          _initializeOutputVideo(job.outputPath!);
        }
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Processing'),
            automaticallyImplyLeading: false,
          ),
          body: activeJob != null
              ? _buildProcessingView(activeJob)
              : _buildResultView(job ?? (completedJobs.isNotEmpty ? completedJobs.last : null)),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 16),
              const Text(
                'Processing failed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProcessingView(ProcessingJob job) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Processing animation
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(26),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Status text
        Text(
          'Processing ${job.inputVideos.length} videos',
          style: theme.textTheme.titleMedium,
        ),
        
        const SizedBox(height: 8),
        
        // Layout info
        Text(
          'Layout: ${job.layoutOption.name}',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Progress indicator
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: job.progress / 100,
                  minHeight: 4,
                  backgroundColor: theme.colorScheme.primary.withAlpha(26),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${job.progress}%',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Cancel button
        OutlinedButton.icon(
          onPressed: () {
            ref.read(cancelJobProvider(job.id).future).then((_) {
              context.go('/');
            });
          },
          icon: const Icon(Icons.close_rounded),
          label: const Text('Cancel'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }
  
  Widget _buildResultView(ProcessingJob? job) {
    final theme = Theme.of(context);
    if (job == null || job.outputPath == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Processing failed',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                job?.errorMessage ?? 'Unknown error',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home_rounded),
              label: const Text('Back to Home'),
            ),
          ],
        ),
      );
    }
    
    final isInitialized = _outputController?.value.isInitialized ?? false;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Success message
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          color: Colors.green.shade50,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Processing completed successfully!',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Video preview
        Expanded(
          child: isInitialized
              ? _buildVideoPlayer()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        
        // Video controls
        if (isInitialized)
          _buildVideoControls(),
        
        // Action buttons
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () => _saveVideo(job.outputPath!),
                icon: const Icon(Icons.save_rounded),
                label: const Text('Save to Gallery'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Sharing functionality not implemented yet'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
                icon: const Icon(Icons.share_rounded),
                label: const Text('Share Video'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildVideoPlayer() {
    if (_outputController == null || !_outputController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return AspectRatio(
      aspectRatio: _outputController!.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_outputController!),
          if (!_isPlaying)
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  size: 36,
                  color: Colors.white,
                ),
                onPressed: _playPause,
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildVideoControls() {
    final theme = Theme.of(context);
    if (_outputController == null) return const SizedBox.shrink();
    
    final duration = _outputController!.value.duration;
    final position = _outputController!.value.position;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.black,
      child: Column(
        children: [
          // Progress slider
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade800,
              thumbColor: Colors.white,
              overlayColor: Colors.white.withAlpha(51),
            ),
            child: Slider(
              value: position.inMilliseconds.toDouble(),
              min: 0,
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                _outputController!.seekTo(Duration(milliseconds: value.toInt()));
                setState(() {});
              },
            ),
          ),
          
          // Time and controls
          Row(
            children: [
              // Current position
              Text(
                _formatDuration(position),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Duration
              Text(
                '/ ${_formatDuration(duration)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade400,
                ),
              ),
              
              const Spacer(),
              
              // Play/pause button
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
                onPressed: _playPause,
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