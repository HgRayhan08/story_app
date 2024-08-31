// To parse this JSON data, do
//
//     final detailStoryModel = detailStoryModelFromJson(jsonString);

import 'dart:convert';

DetailStoryModel detailStoryModelFromJson(String str) =>
    DetailStoryModel.fromJson(json.decode(str));

String detailStoryModelToJson(DetailStoryModel data) =>
    json.encode(data.toJson());

class DetailStoryModel {
  bool error;
  String message;
  Story story;

  DetailStoryModel({
    required this.error,
    required this.message,
    required this.story,
  });

  factory DetailStoryModel.fromJson(Map<String, dynamic> json) =>
      DetailStoryModel(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };
}

class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double lat;
  double lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"] != null ? json["lat"].toDouble() : 0.0,
        lon: json["lon"] != null ? json["lon"].toDouble() : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
