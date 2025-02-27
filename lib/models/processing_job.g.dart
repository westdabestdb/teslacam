// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcessingJobImpl _$$ProcessingJobImplFromJson(Map<String, dynamic> json) =>
    _$ProcessingJobImpl(
      id: json['id'] as String,
      inputVideos: (json['inputVideos'] as List<dynamic>)
          .map((e) => VideoFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      layoutOption:
          LayoutOption.fromJson(json['layoutOption'] as Map<String, dynamic>),
      outputPath: json['outputPath'] as String?,
      status: $enumDecodeNullable(_$ProcessingStatusEnumMap, json['status']) ??
          ProcessingStatus.queued,
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      errorMessage: json['errorMessage'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProcessingJobImplToJson(_$ProcessingJobImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inputVideos': instance.inputVideos,
      'layoutOption': instance.layoutOption,
      'outputPath': instance.outputPath,
      'status': _$ProcessingStatusEnumMap[instance.status]!,
      'progress': instance.progress,
      'errorMessage': instance.errorMessage,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ProcessingStatusEnumMap = {
  ProcessingStatus.queued: 0,
  ProcessingStatus.processing: 1,
  ProcessingStatus.completed: 2,
  ProcessingStatus.failed: 3,
  ProcessingStatus.cancelled: 4,
};
