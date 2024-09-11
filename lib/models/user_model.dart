class MyUser {
    final List<Result> results;

    MyUser({
        required this.results,
    });

    factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

}


class Result {
    final Name name;
    final Picture picture;


    Result({
        required this.name,
        required this.picture,
    });
    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: Name.fromJson(json["name"]),
        picture: Picture.fromJson(json["picture"]),
    );

}


class Name {
    final String title;
    final String first;
    final String last;

    Name({
        required this.title,
        required this.first,
        required this.last,
    });

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json["title"],
        first: json["first"],
        last: json["last"],
    );


}

class Picture {
    final String large;
    final String medium;
    final String thumbnail;

    Picture({
        required this.large,
        required this.medium,
        required this.thumbnail,
    });

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        large: json["large"],
        medium: json["medium"],
        thumbnail: json["thumbnail"],
    );


}
