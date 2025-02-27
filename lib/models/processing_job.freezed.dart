// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'processing_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcessingJob _$ProcessingJobFromJson(Map<String, dynamic> json) {
  return _ProcessingJob.fromJson(json);
}

/// @nodoc
mixin _$ProcessingJob {
  /// Unique identifier for the job
  String get id => throw _privateConstructorUsedError;

  /// List of input video files
  List<VideoFile> get inputVideos => throw _privateConstructorUsedError;

  /// Layout option for the merged video
  LayoutOption get layoutOption => throw _privateConstructorUsedError;

  /// Output file path
  String? get outputPath => throw _privateConstructorUsedError;

  /// Current status of the job
  ProcessingStatus get status => throw _privateConstructorUsedError;

  /// Progress percentage (0-100)
  int get progress => throw _privateConstructorUsedError;

  /// Error message if the job failed
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Start time of the job
  DateTime? get startTime => throw _privateConstructorUsedError;

  /// End time of the job
  DateTime? get endTime => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Last update timestamp
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProcessingJob to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProcessingJobCopyWith<ProcessingJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessingJobCopyWith<$Res> {
  factory $ProcessingJobCopyWith(
          ProcessingJob value, $Res Function(ProcessingJob) then) =
      _$ProcessingJobCopyWithImpl<$Res, ProcessingJob>;
  @useResult
  $Res call(
      {String id,
      List<VideoFile> inputVideos,
      LayoutOption layoutOption,
      String? outputPath,
      ProcessingStatus status,
      int progress,
      String? errorMessage,
      DateTime? startTime,
      DateTime? endTime,
      DateTime createdAt,
      DateTime updatedAt});

  $LayoutOptionCopyWith<$Res> get layoutOption;
}

/// @nodoc
class _$ProcessingJobCopyWithImpl<$Res, $Val extends ProcessingJob>
    implements $ProcessingJobCopyWith<$Res> {
  _$ProcessingJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inputVideos = null,
    Object? layoutOption = null,
    Object? outputPath = freezed,
    Object? status = null,
    Object? progress = null,
    Object? errorMessage = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      inputVideos: null == inputVideos
          ? _value.inputVideos
          : inputVideos // ignore: cast_nullable_to_non_nullable
              as List<VideoFile>,
      layoutOption: null == layoutOption
          ? _value.layoutOption
          : layoutOption // ignore: cast_nullable_to_non_nullable
              as LayoutOption,
      outputPath: freezed == outputPath
          ? _value.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProcessingStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LayoutOptionCopyWith<$Res> get layoutOption {
    return $LayoutOptionCopyWith<$Res>(_value.layoutOption, (value) {
      return _then(_value.copyWith(layoutOption: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProcessingJobImplCopyWith<$Res>
    implements $ProcessingJobCopyWith<$Res> {
  factory _$$ProcessingJobImplCopyWith(
          _$ProcessingJobImpl value, $Res Function(_$ProcessingJobImpl) then) =
      __$$ProcessingJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<VideoFile> inputVideos,
      LayoutOption layoutOption,
      String? outputPath,
      ProcessingStatus status,
      int progress,
      String? errorMessage,
      DateTime? startTime,
      DateTime? endTime,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $LayoutOptionCopyWith<$Res> get layoutOption;
}

/// @nodoc
class __$$ProcessingJobImplCopyWithImpl<$Res>
    extends _$ProcessingJobCopyWithImpl<$Res, _$ProcessingJobImpl>
    implements _$$ProcessingJobImplCopyWith<$Res> {
  __$$ProcessingJobImplCopyWithImpl(
      _$ProcessingJobImpl _value, $Res Function(_$ProcessingJobImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inputVideos = null,
    Object? layoutOption = null,
    Object? outputPath = freezed,
    Object? status = null,
    Object? progress = null,
    Object? errorMessage = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ProcessingJobImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      inputVideos: null == inputVideos
          ? _value._inputVideos
          : inputVideos // ignore: cast_nullable_to_non_nullable
              as List<VideoFile>,
      layoutOption: null == layoutOption
          ? _value.layoutOption
          : layoutOption // ignore: cast_nullable_to_non_nullable
              as LayoutOption,
      outputPath: freezed == outputPath
          ? _value.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProcessingStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcessingJobImpl extends _ProcessingJob {
  const _$ProcessingJobImpl(
      {required this.id,
      required final List<VideoFile> inputVideos,
      required this.layoutOption,
      this.outputPath,
      this.status = ProcessingStatus.queued,
      this.progress = 0,
      this.errorMessage,
      this.startTime,
      this.endTime,
      required this.createdAt,
      required this.updatedAt})
      : _inputVideos = inputVideos,
        super._();

  factory _$ProcessingJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcessingJobImplFromJson(json);

  /// Unique identifier for the job
  @override
  final String id;

  /// List of input video files
  final List<VideoFile> _inputVideos;

  /// List of input video files
  @override
  List<VideoFile> get inputVideos {
    if (_inputVideos is EqualUnmodifiableListView) return _inputVideos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputVideos);
  }

  /// Layout option for the merged video
  @override
  final LayoutOption layoutOption;

  /// Output file path
  @override
  final String? outputPath;

  /// Current status of the job
  @override
  @JsonKey()
  final ProcessingStatus status;

  /// Progress percentage (0-100)
  @override
  @JsonKey()
  final int progress;

  /// Error message if the job failed
  @override
  final String? errorMessage;

  /// Start time of the job
  @override
  final DateTime? startTime;

  /// End time of the job
  @override
  final DateTime? endTime;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  /// Last update timestamp
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ProcessingJob(id: $id, inputVideos: $inputVideos, layoutOption: $layoutOption, outputPath: $outputPath, status: $status, progress: $progress, errorMessage: $errorMessage, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessingJobImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._inputVideos, _inputVideos) &&
            (identical(other.layoutOption, layoutOption) ||
                other.layoutOption == layoutOption) &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_inputVideos),
      layoutOption,
      outputPath,
      status,
      progress,
      errorMessage,
      startTime,
      endTime,
      createdAt,
      updatedAt);

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessingJobImplCopyWith<_$ProcessingJobImpl> get copyWith =>
      __$$ProcessingJobImplCopyWithImpl<_$ProcessingJobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessingJobImplToJson(
      this,
    );
  }
}

abstract class _ProcessingJob extends ProcessingJob {
  const factory _ProcessingJob(
      {required final String id,
      required final List<VideoFile> inputVideos,
      required final LayoutOption layoutOption,
      final String? outputPath,
      final ProcessingStatus status,
      final int progress,
      final String? errorMessage,
      final DateTime? startTime,
      final DateTime? endTime,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ProcessingJobImpl;
  const _ProcessingJob._() : super._();

  factory _ProcessingJob.fromJson(Map<String, dynamic> json) =
      _$ProcessingJobImpl.fromJson;

  /// Unique identifier for the job
  @override
  String get id;

  /// List of input video files
  @override
  List<VideoFile> get inputVideos;

  /// Layout option for the merged video
  @override
  LayoutOption get layoutOption;

  /// Output file path
  @override
  String? get outputPath;

  /// Current status of the job
  @override
  ProcessingStatus get status;

  /// Progress percentage (0-100)
  @override
  int get progress;

  /// Error message if the job failed
  @override
  String? get errorMessage;

  /// Start time of the job
  @override
  DateTime? get startTime;

  /// End time of the job
  @override
  DateTime? get endTime;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Last update timestamp
  @override
  DateTime get updatedAt;

  /// Create a copy of ProcessingJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessingJobImplCopyWith<_$ProcessingJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
