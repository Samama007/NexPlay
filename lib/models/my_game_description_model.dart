class DescriptionModel {
  final int id;
  final String name;
  final String description;
  final int? metacritic;
  final DateTime? released;
  final String? backgroundImage;
  final String? backgroundImageAdditional;
  final String? website;
  final List<Developer> developers;
  final List<Rating> ratings;
  final double rating;

  DescriptionModel({
    required this.id,
    required this.rating,
    required this.name,
    required this.description,
    this.metacritic,
    this.released,
    this.backgroundImage,
    this.backgroundImageAdditional,
    this.website,
    required this.developers,
    required this.ratings,
  });

  factory DescriptionModel.fromJson(Map<String, dynamic> json) => DescriptionModel(
        id: json["id"] as int,
        name: json["name"] as String,
        description: json["description"] as String,
        metacritic: json["metacritic"] as int?,
        released: json["released"] != null ? DateTime.parse(json["released"] as String) : null,
        backgroundImageAdditional: json["background_image_additional"] as String?,
        website: json["website"] as String?,
        developers: (json["developers"] as List<dynamic>?)?.map((x) => Developer.fromJson(x as Map<String, dynamic>)).toList() ?? [],
        ratings: (json["ratings"] as List<dynamic>?)?.map((x) => Rating.fromJson(x as Map<String, dynamic>)).toList() ?? [],
        backgroundImage: json["background_image"] as String?,
        rating: (json["rating"] as num).toDouble(),
      );
}

class Developer {
  final int id;
  final String name;
  final String? imageBackground;

  Developer({
    required this.id,
    required this.name,
    this.imageBackground,
  });

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
        id: json["id"] as int,
        name: json["name"] as String,
        imageBackground: json["image_background"] as String?,
      );
}

class Rating {
  final int id;
  final String title;
  final int count;
  final double percent;

  Rating({
    required this.id,
    required this.title,
    required this.count,
    required this.percent,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"] as int,
        title: json["title"] as String,
        count: json["count"] as int,
        percent: (json["percent"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "count": count,
        "percent": percent,
      };
}
