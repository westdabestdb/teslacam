import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslacam/models/processing_job.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/models/layout_option.dart';
import 'package:teslacam/providers/video_providers.dart';

part 'processing_providers.g.dart';

/// Provider for all processing jobs
@riverpod
class ProcessingJobs extends _$ProcessingJobs {
  @override
  List<ProcessingJob> build() {
    return [];
  }
  
  /// Add a new processing job
  void addJob(ProcessingJob job) {
    state = [...state, job];
  }
  
  /// Remove a processing job
  void removeJob(String jobId) {
    state = state.where((job) => job.id != jobId).toList();
  }
  
  /// Update a processing job
  void updateJob(ProcessingJob updatedJob) {
    state = state.map((job) => 
      job.id == updatedJob.id ? updatedJob : job
    ).toList();
  }
  
  /// Get active jobs
  List<ProcessingJob> get activeJobs {
    return state.where((job) => job.isActive).toList();
  }
  
  /// Get completed jobs
  List<ProcessingJob> get completedJobs {
    return state.where((job) => job.isCompleted).toList();
  }
  
  /// Get failed jobs
  List<ProcessingJob> get failedJobs {
    return state.where((job) => job.hasFailed).toList();
  }
}

/// Provider for the currently active processing job
@riverpod
class ActiveJob extends _$ActiveJob {
  @override
  ProcessingJob? build() {
    return null;
  }
  
  /// Set the active job
  void setActiveJob(ProcessingJob? job) {
    state = job;
  }
  
  /// Clear the active job
  void clearActiveJob() {
    state = null;
  }
}

/// Provider for managing the processing state
@riverpod
class ProcessingState extends _$ProcessingState {
  @override
  FutureOr<ProcessingJob?> build() => null;

  Future<ProcessingJob> startProcessing(List<VideoFile> videos, LayoutOption layout) async {
    state = const AsyncLoading();
    
    final job = ProcessingJob.create(
      inputVideos: videos,
      layoutOption: layout,
    );
    
    ref.read(processingJobsProvider.notifier).addJob(job);
    ref.read(activeJobProvider.notifier).setActiveJob(job);
    
    try {
      final ffmpegService = ref.read(ffmpegServiceProvider);
      final updatedJob = await ffmpegService.processJob(
        job,
        onProgress: (updatedJob) {
          ref.read(processingJobsProvider.notifier).updateJob(updatedJob);
          ref.read(activeJobProvider.notifier).setActiveJob(updatedJob);
        },
      );
      
      ref.read(processingJobsProvider.notifier).updateJob(updatedJob);
      if (updatedJob.isCompleted || updatedJob.hasFailed) {
        ref.read(activeJobProvider.notifier).clearActiveJob();
      }
      
      state = AsyncData(updatedJob);
      return updatedJob;
    } catch (error, stackTrace) {
      final failedJob = job.copyWith(
        status: ProcessingStatus.failed,
        errorMessage: error.toString(),
        endTime: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      ref.read(processingJobsProvider.notifier).updateJob(failedJob);
      ref.read(activeJobProvider.notifier).clearActiveJob();
      
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

/// Provider for cancelling a processing job
@riverpod
Future<bool> cancelJob(
  CancelJobRef ref,
  String jobId,
) async {
  final ffmpegService = ref.read(ffmpegServiceProvider);
  final processingJobs = ref.read(processingJobsProvider.notifier);
  final activeJob = ref.read(activeJobProvider.notifier);
  
  // Find the job
  final jobs = ref.read(processingJobsProvider);
  final jobIndex = jobs.indexWhere((job) => job.id == jobId);
  
  // Return false if job not found
  if (jobIndex == -1) return false;
  
  final job = jobs[jobIndex];
  
  // Cancel the job
  final success = await ffmpegService.cancelJob(job);
  
  if (success) {
    // Update the job status
    final updatedJob = job.copyWith(
      status: ProcessingStatus.cancelled,
      endTime: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    // Update the job in the list
    processingJobs.updateJob(updatedJob);
    
    // Clear active job if this was the active one
    final currentActiveJob = ref.read(activeJobProvider);
    if (currentActiveJob != null && currentActiveJob.id == jobId) {
      activeJob.clearActiveJob();
    }
  }
  
  return success;
} 