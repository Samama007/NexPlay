class CategoriesModel {
  final int count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  CategoriesModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;
  final List<Game> games;

  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
    required this.games,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
        games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
      );
}

class Game {
  final int id;
  final String slug;
  final String name;
  final int added;

  Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.added,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        added: json["added"],
      );
}
