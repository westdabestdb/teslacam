// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoFile _$VideoFileFromJson(Map<String, dynamic> json) {
  return _VideoFile.fromJson(json);
}

/// @nodoc
mixin _$VideoFile {
  /// Unique identifier for the video file
  String get id => throw _privateConstructorUsedError;

  /// Path to the video file on the device
  String get path => throw _privateConstructorUsedError;

  /// Name of the video file
  String get name => throw _privateConstructorUsedError;

  /// Size of the video file in bytes
  int get size => throw _privateConstructorUsedError;

  /// Duration of the video in milliseconds
  int? get durationMs => throw _privateConstructorUsedError;

  /// Width of the video in pixels
  int? get width => throw _privateConstructorUsedError;

  /// Height of the video in pixels
  int? get height => throw _privateConstructorUsedError;

  /// Path to the thumbnail image for this video
  String? get thumbnailPath => throw _privateConstructorUsedError;

  /// Whether thumbnail generation has been attempted
  bool get thumbnailAttempted => throw _privateConstructorUsedError;

  /// Position in the layout (e.g., "front", "back", "left", "right")
  String? get position => throw _privateConstructorUsedError;

  /// Group identifier for related videos
  String? get groupId => throw _privateConstructorUsedError;

  /// Creation timestamp
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this VideoFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoFileCopyWith<VideoFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoFileCopyWith<$Res> {
  factory $VideoFileCopyWith(VideoFile value, $Res Function(VideoFile) then) =
      _$VideoFileCopyWithImpl<$Res, VideoFile>;
  @useResult
  $Res call(
      {String id,
      String path,
      String name,
      int size,
      int? durationMs,
      int? width,
      int? height,
      String? thumbnailPath,
      bool thumbnailAttempted,
      String? position,
      String? groupId,
      DateTime createdAt});
}

/// @nodoc
class _$VideoFileCopyWithImpl<$Res, $Val extends VideoFile>
    implements $VideoFileCopyWith<$Res> {
  _$VideoFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? name = null,
    Object? size = null,
    Object? durationMs = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? thumbnailPath = freezed,
    Object? thumbnailAttempted = null,
    Object? position = freezed,
    Object? groupId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailAttempted: null == thumbnailAttempted
          ? _value.thumbnailAttempted
          : thumbnailAttempted // ignore: cast_nullable_to_non_nullable
              as bool,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoFileImplCopyWith<$Res>
    implements $VideoFileCopyWith<$Res> {
  factory _$$VideoFileImplCopyWith(
          _$VideoFileImpl value, $Res Function(_$VideoFileImpl) then) =
      __$$VideoFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String path,
      String name,
      int size,
      int? durationMs,
      int? width,
      int? height,
      String? thumbnailPath,
      bool thumbnailAttempted,
      String? position,
      String? groupId,
      DateTime createdAt});
}

/// @nodoc
class __$$VideoFileImplCopyWithImpl<$Res>
    extends _$VideoFileCopyWithImpl<$Res, _$VideoFileImpl>
    implements _$$VideoFileImplCopyWith<$Res> {
  __$$VideoFileImplCopyWithImpl(
      _$VideoFileImpl _value, $Res Function(_$VideoFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? name = null,
    Object? size = null,
    Object? durationMs = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? thumbnailPath = freezed,
    Object? thumbnailAttempted = null,
    Object? position = freezed,
    Object? groupId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$VideoFileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailAttempted: null == thumbnailAttempted
          ? _value.thumbnailAttempted
          : thumbnailAttempted // ignore: cast_nullable_to_non_nullable
              as bool,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoFileImpl extends _VideoFile {
  const _$VideoFileImpl(
      {required this.id,
      required this.path,
      required this.name,
      required this.size,
      this.durationMs,
      this.width,
      this.height,
      this.thumbnailPath,
      this.thumbnailAttempted = false,
      this.position,
      this.groupId,
      required this.createdAt})
      : super._();

  factory _$VideoFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoFileImplFromJson(json);

  /// Unique identifier for the video file
  @override
  final String id;

  /// Path to the video file on the device
  @override
  final String path;

  /// Name of the video file
  @override
  final String name;

  /// Size of the video file in bytes
  @override
  final int size;

  /// Duration of the video in milliseconds
  @override
  final int? durationMs;

  /// Width of the video in pixels
  @override
  final int? width;

  /// Height of the video in pixels
  @override
  final int? height;

  /// Path to the thumbnail image for this video
  @override
  final String? thumbnailPath;

  /// Whether thumbnail generation has been attempted
  @override
  @JsonKey()
  final bool thumbnailAttempted;

  /// Position in the layout (e.g., "front", "back", "left", "right")
  @override
  final String? position;

  /// Group identifier for related videos
  @override
  final String? groupId;

  /// Creation timestamp
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'VideoFile(id: $id, path: $path, name: $name, size: $size, durationMs: $durationMs, width: $width, height: $height, thumbnailPath: $thumbnailPath, thumbnailAttempted: $thumbnailAttempted, position: $position, groupId: $groupId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoFileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.thumbnailAttempted, thumbnailAttempted) ||
                other.thumbnailAttempted == thumbnailAttempted) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      path,
      name,
      size,
      durationMs,
      width,
      height,
      thumbnailPath,
      thumbnailAttempted,
      position,
      groupId,
      createdAt);

  /// Create a copy of VideoFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoFileImplCopyWith<_$VideoFileImpl> get copyWith =>
      __$$VideoFileImplCopyWithImpl<_$VideoFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoFileImplToJson(
      this,
    );
  }
}

abstract class _VideoFile extends VideoFile {
  const factory _VideoFile(
      {required final String id,
      required final String path,
      required final String name,
      required final int size,
      final int? durationMs,
      final int? width,
      final int? height,
      final String? thumbnailPath,
      final bool thumbnailAttempted,
      final String? position,
      final String? groupId,
      required final DateTime createdAt}) = _$VideoFileImpl;
  const _VideoFile._() : super._();

  factory _VideoFile.fromJson(Map<String, dynamic> json) =
      _$VideoFileImpl.fromJson;

  /// Unique identifier for the video file
  @override
  String get id;

  /// Path to the video file on the device
  @override
  String get path;

  /// Name of the video file
  @override
  String get name;

  /// Size of the video file in bytes
  @override
  int get size;

  /// Duration of the video in milliseconds
  @override
  int? get durationMs;

  /// Width of the video in pixels
  @override
  int? get width;

  /// Height of the video in pixels
  @override
  int? get height;

  /// Path to the thumbnail image for this video
  @override
  String? get thumbnailPath;

  /// Whether thumbnail generation has been attempted
  @override
  bool get thumbnailAttempted;

  /// Position in the layout (e.g., "front", "back", "left", "right")
  @override
  String? get position;

  /// Group identifier for related videos
  @override
  String? get groupId;

  /// Creation timestamp
  @override
  DateTime get createdAt;

  /// Create a copy of VideoFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoFileImplCopyWith<_$VideoFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
