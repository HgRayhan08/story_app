// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:story_app/data/repository/shared_pref_repository.dart';
import 'package:story_app/data/repository/story_repository.dart';
import 'package:story_app/domain/usecase/create_story/story_params.dart';
import 'package:story_app/domain/usecase/usecase.dart';

class CreateStoryUsecase implements UseCase<String, StoryParams> {
  final StoryRepository storyRepository;
  final SharedPrefRepository sharedPrefRepository;

  CreateStoryUsecase({
    required this.storyRepository,
    required this.sharedPrefRepository,
  });

  @override
  Future<String> call(StoryParams params) async {
    final pref = await sharedPrefRepository.getLogin();
    if (pref!.isNotEmpty) {
      final create = await storyRepository.addNewStory(
        description: params.description,
        bytes: params.bytes,
        fileName: params.fileName,
        token: pref,
        lat: params.lat!,
        lon: params.lon!,
      );
      if (create.isNotEmpty) {
        return "Succses Create Story";
      } else {
        return "Failed Create Story";
      }
    } else {
      return "Failed get data token";
    }
  }
}
