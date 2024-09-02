import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:story_app/domain/model/detail_story_model.dart';

part 'all_story_model.freezed.dart';
part 'all_story_model.g.dart';

@freezed
class ListStoryModel with _$ListStoryModel {
  factory ListStoryModel({
    required bool error,
    required String message,
    List<StoryModel?>? listStory,
  }) = _ListStoryModel;

  factory ListStoryModel.fromJson(Map<String, dynamic> json) =>
      _$ListStoryModelFromJson(json);
}
