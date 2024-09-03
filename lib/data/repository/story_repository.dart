import 'package:story_app/domain/model/all_story_model.dart';
import 'package:story_app/domain/model/detail_story_model.dart';

abstract interface class StoryRepository {
  Future<String> addNewStory({
    required String description,
    required List<int> bytes,
    required String fileName,
    required String token,
    double lat,
    double lon,
  });
  Future<ListStoryModel> getAllStory(
      {required String token, required int sizeItems, required int page});
  Future<DetailStoryModel> getDetailStory(
      {required String id, required String token});
}
