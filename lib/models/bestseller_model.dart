class BestsellerModel {
  final int id;
  final String? name;
  final String? backgroundImage;
  final DateTime? released;
  final double? rating;
  final int? ratingsCount;
  final int? playtime;
  final List<ShortScreenshot>? shortScreenshots;
  final EsrbRating? esrbRating;

  BestsellerModel({
    required this.id,
    this.name,
    this.backgroundImage,
    this.released,
    this.rating,
    this.ratingsCount,
    this.playtime,
    this.shortScreenshots,
    this.esrbRating,
  });

  factory BestsellerModel.fromJson(Map<String, dynamic> json) {
    return BestsellerModel(
      id: json['id'] ?? 0, // Providing a default value in case `id` is null
      name: json['name'] as String?, // Nullable, no default value needed
      backgroundImage: json['background_image'] as String?, // Nullable
      released: json['released'] != null ? DateTime.tryParse(json['released']) : null, // Nullable and safe parsing for DateTime
      rating: (json['rating'] as num?)?.toDouble(), // Nullable and type-cast to double
      ratingsCount: json['ratings_count'] as int?, // Nullable
      playtime: json['playtime'] as int?, // Nullable
      shortScreenshots: json['short_screenshots'] != null ? List<ShortScreenshot>.from((json['short_screenshots'] as List<dynamic>).map((x) => ShortScreenshot.fromJson(x))) : null, // Nullable list
      esrbRating: json['esrb_rating'] != null ? EsrbRating.fromJson(json['esrb_rating']) : null, // Nullable esrbRating object
    );
  }
}

class ShortScreenshot {
  final int? id;
  final String? image;

  ShortScreenshot({
    this.id,
    this.image,
  });

  factory ShortScreenshot.fromJson(Map<String, dynamic> json) {
    return ShortScreenshot(
      id: json['id'] as int?, // Nullable
      image: json['image'] as String?, // Nullable
    );
  }
}

class EsrbRating {
  final int? id;
  final String? name;
  final String? slug;

  EsrbRating({
    this.id,
    this.name,
    this.slug,
  });

  factory EsrbRating.fromJson(Map<String, dynamic> json) {
    return EsrbRating(
      id: json['id'] as int?, // Nullable
      name: json['name'] as String?, // Nullable
      slug: json['slug'] as String?, // Nullable
    );
  }
}
