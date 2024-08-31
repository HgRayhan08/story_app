import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/data/story/story_data.dart';

part 'story_provider.g.dart';

@riverpod
StoryData storyData(StoryDataRef ref) => StoryData();
