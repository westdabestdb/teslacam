// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LayoutOptionImpl _$$LayoutOptionImplFromJson(Map<String, dynamic> json) =>
    _$LayoutOptionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$LayoutTypeEnumMap, json['type']),
      videoCount: (json['video_count'] as num?)?.toInt() ?? 4,
      minVideoCount: (json['min_video_count'] as num?)?.toInt() ?? 2,
      thumbnailPath: json['thumbnail_path'] as String?,
      customConfig: json['custom_config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$LayoutOptionImplToJson(_$LayoutOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$LayoutTypeEnumMap[instance.type]!,
      'video_count': instance.videoCount,
      'min_video_count': instance.minVideoCount,
      'thumbnail_path': instance.thumbnailPath,
      'custom_config': instance.customConfig,
    };

const _$LayoutTypeEnumMap = {
  LayoutType.frontBack: 0,
  LayoutType.frontSides: 1,
  LayoutType.backSides: 2,
  LayoutType.allSides: 3,
  LayoutType.pip: 4,
};
