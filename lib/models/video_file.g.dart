// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoFileImpl _$$VideoFileImplFromJson(Map<String, dynamic> json) =>
    _$VideoFileImpl(
      id: json['id'] as String,
      path: json['path'] as String,
      name: json['name'] as String,
      size: (json['size'] as num).toInt(),
      durationMs: (json['durationMs'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      thumbnailPath: json['thumbnailPath'] as String?,
      thumbnailAttempted: json['thumbnailAttempted'] as bool? ?? false,
      position: json['position'] as String?,
      groupId: json['groupId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$VideoFileImplToJson(_$VideoFileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'name': instance.name,
      'size': instance.size,
      'durationMs': instance.durationMs,
      'width': instance.width,
      'height': instance.height,
      'thumbnailPath': instance.thumbnailPath,
      'thumbnailAttempted': instance.thumbnailAttempted,
      'position': instance.position,
      'groupId': instance.groupId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
