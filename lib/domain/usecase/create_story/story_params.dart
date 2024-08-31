class StoryParams {
  final String description;
  final List<int> bytes;
  final String fileName;
  final double? lat;
  final double? lon;

  StoryParams(
      {required this.description,
      required this.bytes,
      required this.fileName,
      this.lat,
      this.lon});
}
