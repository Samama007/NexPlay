class ReleasedModel {
  final int id;
  final String name;
  final String backgroundImage;
  final DateTime released;
  final int playtime;
  final double rating;

  final List<ShortScreenshot> shortScreenshots;

  ReleasedModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.released,
    required this.playtime,
    required this.rating,
    required this.shortScreenshots,
  });

  factory ReleasedModel.fromJson(Map<String, dynamic> json) {
    return ReleasedModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      released: DateTime.parse(json['released']),
      playtime: json['playtime'],
      rating: json['rating']?.toDouble(),
      shortScreenshots: List<ShortScreenshot>.from(
        json['short_screenshots'].map((x) => ShortScreenshot.fromJson(x)),
      ),
    );
  }
}

class ShortScreenshot {
  int id;
  String image;

  ShortScreenshot({
    required this.id,
    required this.image,
  });

  factory ShortScreenshot.fromJson(Map<String, dynamic> json) => ShortScreenshot(
        id: json["id"],
        image: json["image"],
      );
}
