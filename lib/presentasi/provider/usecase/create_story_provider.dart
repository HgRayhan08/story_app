import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/create_story/create_story_usecase.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';
import 'package:story_app/presentasi/provider/repository/story_provider.dart';

part 'create_story_provider.g.dart';

@riverpod
CreateStoryUsecase createStoryUsecase(CreateStoryUsecaseRef ref) =>
    CreateStoryUsecase(
        storyRepository: ref.watch(storyDataProvider),
        sharedPrefRepository: ref.watch(sharedPrefDataProvider));
