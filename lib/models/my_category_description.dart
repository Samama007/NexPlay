class CategoryDescriptionModel {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;
  final DateTime released;
  final int playtime;
  final int ratingsCount;
  final List<ShortScreenshot> shortScreenshots;
  final EsrbRating? esrbRating;

  CategoryDescriptionModel({
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

  factory CategoryDescriptionModel.fromJson(Map<String, dynamic> json) => CategoryDescriptionModel(
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
        esrbRating: json['esrb_rating'] != null ? EsrbRating.fromJson(json['esrb_rating']) : null, // Handle null case
      );
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
  final int id;
  final String name;
  final String slug;
  final String nameEn;
  final String nameRu;

  EsrbRating({
    required this.id,
    required this.name,
    required this.slug,
    required this.nameEn,
    required this.nameRu,
  });

  factory EsrbRating.fromJson(Map<String, dynamic> json) => EsrbRating(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        nameEn: json["name_en"],
        nameRu: json["name_ru"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "name_en": nameEn,
        "name_ru": nameRu,
      };
}
