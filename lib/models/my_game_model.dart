class GameModel {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;
  final DateTime released;
  final int playtime;
  final int ratingsCount;
  final EsrbRating esrbRating;
  final List<ShortScreenshot> shortScreenshots;

  GameModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.released,
    required this.playtime,
    required this.ratingsCount,
    required this.rating,
    required this.shortScreenshots,
    required this.esrbRating,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json["name"],
      backgroundImage: json["background_image"],
      rating: json["rating"]?.toDouble(),
      released: DateTime.parse(json['released']),
      playtime: json['playtime'],
      ratingsCount: json['ratings_count'],
      shortScreenshots: List<ShortScreenshot>.from(
        json['short_screenshots'].map((x) => ShortScreenshot.fromJson(x)),
      ),
      esrbRating: EsrbRating.fromJson(json['esrb_rating']),
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

class EsrbRating {
  int id;
  String name;
  String slug;

  EsrbRating({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory EsrbRating.fromJson(Map<String, dynamic> json) => EsrbRating(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );
}
