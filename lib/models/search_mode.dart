class SearchModel {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;
  final DateTime released;
  final int playtime;
  final int ratingsCount;
  final List<ShortScreenshot> shortScreenshots;
  final EsrbRating? esrbRating;

  SearchModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.rating,
    required this.released,
    required this.playtime,
    required this.ratingsCount,
    required this.shortScreenshots,
    required this.esrbRating,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      backgroundImage: json['background_image'],
      rating: (json['rating']).toDouble(),
      released: DateTime.parse(json['released'] as String),
      playtime: json['playtime'],
      ratingsCount: json['ratings_count'],
      shortScreenshots: List<ShortScreenshot>.from(
        json['short_screenshots'].map((x) => ShortScreenshot.fromJson(x)),
      ),
      esrbRating: json['esrb_rating'] != null ? EsrbRating.fromJson(json['esrb_rating']) : null,
    );
  }
}

class ShortScreenshot {
  final int id;
  final String? image;

  ShortScreenshot({
    required this.id,
    this.image,
  });

  factory ShortScreenshot.fromJson(Map<String, dynamic> json) => ShortScreenshot(
        id: json['id'] as int,
        image: json['image'] as String?,
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
