import 'dart:io';
import 'package:dio/dio.dart';
import 'package:story_app/data/repository/story_repository.dart';
import 'package:story_app/domain/model/all_story.dart';
import 'package:story_app/domain/model/detail_story.dart';

class StoryData implements StoryRepository {
  @override
  Future<String> addNewStory(
      {required String description,
      required List<int> bytes,
      required String fileName,
      required String token,
      double? lat,
      double? lon}) async {
    var formData = FormData.fromMap({
      'photo': MultipartFile.fromBytes(bytes, filename: fileName),
      'description': description,
      'lat': lat ?? 0.0,
      'lon': lon ?? 0.0
    });

    final response = await Dio().post(
      "https://story-api.dicoding.dev/v1/stories",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          HttpHeaders.contentTypeHeader: "multipart/form-data"
        },
      ),
    );
    if (response.data != null) {
      return "upload story Succses";
    } else {
      return "upload story Failed";
    }
  }

  @override
  Future<AllStoryModel> getAllStory({required String token}) async {
    final response = await Dio().get(
      "https://story-api.dicoding.dev/v1/stories",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    // print(response.data.toString());
    if (response.data != null) {
      return AllStoryModel.fromJson(response.data);
    } else {
      return throw Exception("Error get detail stories");
    }
  }

  @override
  Future<DetailStoryModel> getDetailStory(
      {required String id, required String token}) async {
    final response = await Dio().get(
      "https://story-api.dicoding.dev/v1/stories/$id",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    if (response.data != null) {
      return DetailStoryModel.fromJson(response.data);
    } else {
      return throw Exception("Error get detail stories");
    }
  }
}
