import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/usecase/get_detail_story/get_detail_story_usecase.dart';
import 'package:story_app/presentasi/provider/repository/shared_pref_provider.dart';
import 'package:story_app/presentasi/provider/repository/story_provider.dart';

part 'get_detail_story_provider.g.dart';

@riverpod
GetDetailStoryUsecase getDetailStoryUsecase(GetDetailStoryUsecaseRef ref) =>
    GetDetailStoryUsecase(
      storyData: ref.watch(storyDataProvider),
      sharedPrefRepository: ref.watch(sharedPrefDataProvider),
    );
