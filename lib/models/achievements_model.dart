class AchievementsModel {
    final int count;
    final String next;
    final dynamic previous;
    final List<Result> results;

    AchievementsModel({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory AchievementsModel.fromJson(Map<String, dynamic> json) => AchievementsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final int id;
    final String name;
    final String description;
    final String image;
    final String percent;

    Result({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.percent,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        percent: json["percent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "percent": percent,
    };
}
