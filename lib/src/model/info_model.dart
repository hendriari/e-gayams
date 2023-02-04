class InfoModel {
  String headerImage;
  List? activityImage;
  String title;
  String description;
  String date;

  InfoModel({
    required this.headerImage,
    required this.title,
    required this.description,
    required this.date,
    this.activityImage,
  });
}
