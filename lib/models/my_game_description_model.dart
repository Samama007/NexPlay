class DescriptionModel {
  final int id;
  final String name;
  final String description;
  final int metacritic;
  final DateTime released;
  final String backgroundImageAdditional;
  final String website;
  final List<Developer> developers;
  final List<Rating> ratings;

  DescriptionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.metacritic,
    required this.released,
    required this.backgroundImageAdditional,
    required this.website,
    required this.developers,
    required this.ratings,
  });

  factory DescriptionModel.fromJson(Map<String, dynamic> json) => DescriptionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        metacritic: json["metacritic"],
        released: DateTime.parse(json["released"]),
        backgroundImageAdditional: json["background_image_additional"],
        website: json["website"],
        developers: List<Developer>.from(json["developers"].map((x) => Developer.fromJson(x))),
        ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      );
}

class Developer {
  final int id;
  final String name;
  final String imageBackground;

  Developer({
    required this.id,
    required this.name,
    required this.imageBackground,
  });

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
        id: json["id"],
        name: json["name"],
        imageBackground: json["image_background"],
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
        id: json["id"],
        title: json["title"],
        count: json["count"],
        percent: json["percent"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "count": count,
        "percent": percent,
      };
}
