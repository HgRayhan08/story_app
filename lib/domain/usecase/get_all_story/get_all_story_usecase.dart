import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/data/repository/story_repository.dart';
import 'package:story_app/domain/model/all_story.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class GetAllStoryUsecase implements UseCase<AllStoryModel, void> {
  final SharedPrefRepository sharedPrefRepository;
  final StoryRepository storyRepository;

  GetAllStoryUsecase({
    required this.sharedPrefRepository,
    required this.storyRepository,
  });

  @override
  Future<AllStoryModel> call(void params) async {
    final token = await sharedPrefRepository.getLogin();
    if (token != null) {
      final story = await storyRepository.getAllStory(token: token);
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
