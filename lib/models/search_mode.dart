// class SearchModel {
//   final int id;
//   final String name;
//   final String backgroundImage;
//   final double rating;
//   final DateTime released;
//   final int playtime;
//   final int ratingsCount;
//   final List<ShortScreenshot> shortScreenshots;

//   SearchModel({
//     required this.id,
//     required this.name,
//     required this.backgroundImage,
//     required this.rating,
//     required this.released,
//     required this.playtime,
//     required this.ratingsCount,
//     required this.shortScreenshots,
//   });

//   factory SearchModel.fromJson(Map<String, dynamic> json) {
//     return SearchModel(
//       id: json['id'],
//       name: json["name"],
//       backgroundImage: json["background_image"] ?? '',
//       rating: json["rating"]?.toDouble(),
//       released: DateTime.parse(json['released']),
//       playtime: json['playtime'],
//       ratingsCount: json['ratings_count'],
//       shortScreenshots: List<ShortScreenshot>.from(
//         json['short_screenshots'].map((x) => ShortScreenshot.fromJson(x)),
//       ),
//     );
//   }
// }

// class ShortScreenshot {
//   int id;
//   String image;

//   ShortScreenshot({
//     required this.id,
//     required this.image,
//   });

//   factory ShortScreenshot.fromJson(Map<String, dynamic> json) => ShortScreenshot(
//         id: json["id"],
//         image: json["image"] ?? '',
//       );
// }



class SearchModel {
  final int id;
  final String name;
  final String? backgroundImage;
  final double? rating;
  final DateTime? released;
  final int? playtime;
  final int? ratingsCount;
  final List<ShortScreenshot> shortScreenshots;

  SearchModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.rating,
    this.released,
    this.playtime,
    this.ratingsCount,
    required this.shortScreenshots,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      released: json['released'] != null ? DateTime.parse(json['released'] as String) : null,
      playtime: json['playtime'] as int?,
      ratingsCount: json['ratings_count'] as int?,
      shortScreenshots: (json['short_screenshots'] as List<dynamic>?)
          ?.map((x) => ShortScreenshot.fromJson(x as Map<String, dynamic>))
          .toList() ?? [],
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