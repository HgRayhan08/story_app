// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/data/story/story_data.dart';
import 'package:story_app/domain/model/detail_story_model.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class GetDetailStoryUsecase implements UseCase<DetailStoryModel, String> {
  final StoryData storyData;
  final SharedPrefRepository sharedPrefRepository;
  GetDetailStoryUsecase({
    required this.storyData,
    required this.sharedPrefRepository,
  });

  @override
  Future<DetailStoryModel> call(String params) async {
    final pref = await sharedPrefRepository.getLogin();
    if (pref!.isNotEmpty) {
      final story = await storyData.getDetailStory(id: params, token: pref);
      if (story.error == false) {
        return story;
      } else {
        return throw Exception("Error get detail stories");
      }
    } else {
      return throw Exception("Error get data user");
    }
  }
}
