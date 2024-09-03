import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/data/repository/story_repository.dart';
import 'package:story_app/domain/model/all_story_model.dart';
import 'package:story_app/domain/usecase/get_all_story/all_story_params.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class GetAllStoryUsecase implements UseCase<ListStoryModel, AllStoryParams> {
  final SharedPrefRepository sharedPrefRepository;
  final StoryRepository storyRepository;

  GetAllStoryUsecase({
    required this.sharedPrefRepository,
    required this.storyRepository,
  });

  @override
  Future<ListStoryModel> call(AllStoryParams params) async {
    final token = await sharedPrefRepository.getLogin();
    if (token != null) {
      final story = await storyRepository.getAllStory(
        token: token,
        sizeItems: params.size,
        page: params.page,
      );
      if (story.error == false) {
        return story;
      } else {
        return throw Exception("Error get detail stories");
      }
    } else {
      return throw Exception("Error get detail stories");
    }
  }
}
