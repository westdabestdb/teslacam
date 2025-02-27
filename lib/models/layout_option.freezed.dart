// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LayoutOption _$LayoutOptionFromJson(Map<String, dynamic> json) {
  return _LayoutOption.fromJson(json);
}

/// @nodoc
mixin _$LayoutOption {
  /// Unique identifier for the layout
  String get id => throw _privateConstructorUsedError;

  /// Name of the layout (e.g., "Front & Back", "All Sides")
  String get name => throw _privateConstructorUsedError;

  /// Description of the layout
  String get description => throw _privateConstructorUsedError;

  /// Layout type
  LayoutType get type => throw _privateConstructorUsedError;

  /// Maximum number of videos this layout supports
  int get videoCount => throw _privateConstructorUsedError;

  /// Minimum number of videos required for this layout
  int get minVideoCount => throw _privateConstructorUsedError;

  /// Preview image path for this layout
  String? get thumbnailPath => throw _privateConstructorUsedError;

  /// Custom configuration for the layout (JSON serializable)
  Map<String, dynamic>? get customConfig => throw _privateConstructorUsedError;

  /// Serializes this LayoutOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LayoutOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LayoutOptionCopyWith<LayoutOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LayoutOptionCopyWith<$Res> {
  factory $LayoutOptionCopyWith(
          LayoutOption value, $Res Function(LayoutOption) then) =
      _$LayoutOptionCopyWithImpl<$Res, LayoutOption>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      LayoutType type,
      int videoCount,
      int minVideoCount,
      String? thumbnailPath,
      Map<String, dynamic>? customConfig});
}

/// @nodoc
class _$LayoutOptionCopyWithImpl<$Res, $Val extends LayoutOption>
    implements $LayoutOptionCopyWith<$Res> {
  _$LayoutOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LayoutOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? videoCount = null,
    Object? minVideoCount = null,
    Object? thumbnailPath = freezed,
    Object? customConfig = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LayoutType,
      videoCount: null == videoCount
          ? _value.videoCount
          : videoCount // ignore: cast_nullable_to_non_nullable
              as int,
      minVideoCount: null == minVideoCount
          ? _value.minVideoCount
          : minVideoCount // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      customConfig: freezed == customConfig
          ? _value.customConfig
          : customConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LayoutOptionImplCopyWith<$Res>
    implements $LayoutOptionCopyWith<$Res> {
  factory _$$LayoutOptionImplCopyWith(
          _$LayoutOptionImpl value, $Res Function(_$LayoutOptionImpl) then) =
      __$$LayoutOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      LayoutType type,
      int videoCount,
      int minVideoCount,
      String? thumbnailPath,
      Map<String, dynamic>? customConfig});
}

/// @nodoc
class __$$LayoutOptionImplCopyWithImpl<$Res>
    extends _$LayoutOptionCopyWithImpl<$Res, _$LayoutOptionImpl>
    implements _$$LayoutOptionImplCopyWith<$Res> {
  __$$LayoutOptionImplCopyWithImpl(
      _$LayoutOptionImpl _value, $Res Function(_$LayoutOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of LayoutOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? videoCount = null,
    Object? minVideoCount = null,
    Object? thumbnailPath = freezed,
    Object? customConfig = freezed,
  }) {
    return _then(_$LayoutOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LayoutType,
      videoCount: null == videoCount
          ? _value.videoCount
          : videoCount // ignore: cast_nullable_to_non_nullable
              as int,
      minVideoCount: null == minVideoCount
          ? _value.minVideoCount
          : minVideoCount // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
      customConfig: freezed == customConfig
          ? _value._customConfig
          : customConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$LayoutOptionImpl extends _LayoutOption with DiagnosticableTreeMixin {
  const _$LayoutOptionImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      this.videoCount = 4,
      this.minVideoCount = 2,
      this.thumbnailPath,
      final Map<String, dynamic>? customConfig})
      : _customConfig = customConfig,
        super._();

  factory _$LayoutOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LayoutOptionImplFromJson(json);

  /// Unique identifier for the layout
  @override
  final String id;

  /// Name of the layout (e.g., "Front & Back", "All Sides")
  @override
  final String name;

  /// Description of the layout
  @override
  final String description;

  /// Layout type
  @override
  final LayoutType type;

  /// Maximum number of videos this layout supports
  @override
  @JsonKey()
  final int videoCount;

  /// Minimum number of videos required for this layout
  @override
  @JsonKey()
  final int minVideoCount;

  /// Preview image path for this layout
  @override
  final String? thumbnailPath;

  /// Custom configuration for the layout (JSON serializable)
  final Map<String, dynamic>? _customConfig;

  /// Custom configuration for the layout (JSON serializable)
  @override
  Map<String, dynamic>? get customConfig {
    final value = _customConfig;
    if (value == null) return null;
    if (_customConfig is EqualUnmodifiableMapView) return _customConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LayoutOption(id: $id, name: $name, description: $description, type: $type, videoCount: $videoCount, minVideoCount: $minVideoCount, thumbnailPath: $thumbnailPath, customConfig: $customConfig)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LayoutOption'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('videoCount', videoCount))
      ..add(DiagnosticsProperty('minVideoCount', minVideoCount))
      ..add(DiagnosticsProperty('thumbnailPath', thumbnailPath))
      ..add(DiagnosticsProperty('customConfig', customConfig));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayoutOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.videoCount, videoCount) ||
                other.videoCount == videoCount) &&
            (identical(other.minVideoCount, minVideoCount) ||
                other.minVideoCount == minVideoCount) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            const DeepCollectionEquality()
                .equals(other._customConfig, _customConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      type,
      videoCount,
      minVideoCount,
      thumbnailPath,
      const DeepCollectionEquality().hash(_customConfig));

  /// Create a copy of LayoutOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LayoutOptionImplCopyWith<_$LayoutOptionImpl> get copyWith =>
      __$$LayoutOptionImplCopyWithImpl<_$LayoutOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LayoutOptionImplToJson(
      this,
    );
  }
}

abstract class _LayoutOption extends LayoutOption {
  const factory _LayoutOption(
      {required final String id,
      required final String name,
      required final String description,
      required final LayoutType type,
      final int videoCount,
      final int minVideoCount,
      final String? thumbnailPath,
      final Map<String, dynamic>? customConfig}) = _$LayoutOptionImpl;
  const _LayoutOption._() : super._();

  factory _LayoutOption.fromJson(Map<String, dynamic> json) =
      _$LayoutOptionImpl.fromJson;

  /// Unique identifier for the layout
  @override
  String get id;

  /// Name of the layout (e.g., "Front & Back", "All Sides")
  @override
  String get name;

  /// Description of the layout
  @override
  String get description;

  /// Layout type
  @override
  LayoutType get type;

  /// Maximum number of videos this layout supports
  @override
  int get videoCount;

  /// Minimum number of videos required for this layout
  @override
  int get minVideoCount;

  /// Preview image path for this layout
  @override
  String? get thumbnailPath;

  /// Custom configuration for the layout (JSON serializable)
  @override
  Map<String, dynamic>? get customConfig;

  /// Create a copy of LayoutOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LayoutOptionImplCopyWith<_$LayoutOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
