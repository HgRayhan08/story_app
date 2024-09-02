import 'package:story_app/domain/model/all_story_lama.dart';
import 'package:story_app/domain/model/detail_story_lama.dart';

abstract interface class StoryRepository {
  Future<String> addNewStory({
    required String description,
    required List<int> bytes,
    required String fileName,
    required String token,
    double lat,
    double lon,
  });
  Future<AllStoryModel> getAllStory(
      {required String token, required int sizeItems, required int page});
  Future<DetailStoryModel> getDetailStory(
      {required String id, required String token});
}
