import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/get_all_story/get_all_story_usecase.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';
import 'package:story_app/presentasi/provider/repository/story_provider.dart';

part 'get_all_story.g.dart';

@riverpod
GetAllStoryUsecase getAllStoryUsecase(GetAllStoryUsecaseRef ref) =>
    GetAllStoryUsecase(
      sharedPrefRepository: ref.watch(sharedPrefDataProvider),
      storyRepository: ref.watch(storyDataProvider),
    );
