import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:teslacam/models/video_file.dart';
import 'package:teslacam/models/layout_option.dart';

part 'processing_job.freezed.dart';
part 'processing_job.g.dart';

/// Status of a processing job
enum ProcessingStatus {
  /// Job is queued but not started
  @JsonValue(0)
  queued,
  
  /// Job is currently processing
  @JsonValue(1)
  processing,
  
  /// Job completed successfully
  @JsonValue(2)
  completed,
  
  /// Job failed
  @JsonValue(3)
  failed,
  
  /// Job was cancelled
  @JsonValue(4)
  cancelled,
}

/// Represents a video processing job
@freezed
class ProcessingJob with _$ProcessingJob {
  const ProcessingJob._();

  const factory ProcessingJob({
    /// Unique identifier for the job
    required String id,
    
    /// List of input video files
    required List<VideoFile> inputVideos,
    
    /// Layout option for the merged video
    required LayoutOption layoutOption,
    
    /// Output file path
    String? outputPath,
    
    /// Current status of the job
    @Default(ProcessingStatus.queued)
    ProcessingStatus status,
    
    /// Progress percentage (0-100)
    @Default(0)
    int progress,
    
    /// Error message if the job failed
    String? errorMessage,
    
    /// Start time of the job
    DateTime? startTime,
    
    /// End time of the job
    DateTime? endTime,
    
    /// Creation timestamp
    required DateTime createdAt,
    
    /// Last update timestamp
    required DateTime updatedAt,
  }) = _ProcessingJob;

  /// Creates a new processing job
  factory ProcessingJob.create({
    required List<VideoFile> inputVideos,
    required LayoutOption layoutOption,
  }) {
    final now = DateTime.now();
    return ProcessingJob(
      id: const Uuid().v4(),
      inputVideos: inputVideos,
      layoutOption: layoutOption,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Converts a ProcessingJob to JSON
  factory ProcessingJob.fromJson(Map<String, dynamic> json) => 
      _$ProcessingJobFromJson(json);
      
  /// Returns the duration of the job in milliseconds
  int? get durationMs {
    if (startTime == null || endTime == null) return null;
    return endTime!.difference(startTime!).inMilliseconds;
  }
  
  /// Returns whether the job is active (queued or processing)
  bool get isActive => status == ProcessingStatus.queued || 
                       status == ProcessingStatus.processing;
                       
  /// Returns whether the job is completed
  bool get isCompleted => status == ProcessingStatus.completed;
  
  /// Returns whether the job has failed
  bool get hasFailed => status == ProcessingStatus.failed;
  
  /// Returns whether the job was cancelled
  bool get isCancelled => status == ProcessingStatus.cancelled;
} 