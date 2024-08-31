import 'package:story_app/domain/model/all_story.dart';
import 'package:story_app/domain/model/detail_story.dart';

abstract interface class StoryRepository {
  Future<String> addNewStory({
    required String description,
    required List<int> bytes,
    required String fileName,
    required String token,
    double lat,
    double lon,
  });
  Future<AllStoryModel> getAllStory({required String token});
  Future<DetailStoryModel> getDetailStory(
      {required String id, required String token});
}
