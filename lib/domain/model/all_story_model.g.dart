// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListStoryModelImpl _$$ListStoryModelImplFromJson(Map<String, dynamic> json) =>
    _$ListStoryModelImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : StoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListStoryModelImplToJson(
        _$ListStoryModelImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
