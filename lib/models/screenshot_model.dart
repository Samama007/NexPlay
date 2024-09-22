class ScreenShotModel {
    final int count;
    final dynamic next;
    final dynamic previous;
    final List<Result> results;

    ScreenShotModel({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory ScreenShotModel.fromJson(Map<String, dynamic> json) => ScreenShotModel(
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
    final String image;
    final int width;
    final int height;
    final bool isDeleted;

    Result({
        required this.id,
        required this.image,
        required this.width,
        required this.height,
        required this.isDeleted,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        image: json["image"],
        width: json["width"],
        height: json["height"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "width": width,
        "height": height,
        "is_deleted": isDeleted,
    };
}
