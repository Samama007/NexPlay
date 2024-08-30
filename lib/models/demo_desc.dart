import 'dart:convert';

Model ModelFromJson(String str) => Model.fromJson(json.decode(str));

String ModelToJson(Model data) => json.encode(data.toJson());

class Model {
    final int id;
    final String name;
    final String description;
    final int metacritic;
    final DateTime released;
    final String backgroundImageAdditional;
    final String website;
    final List<Store> stores;
    final List<Developer> developers;
    final List<Developer> genres;
    final List<Developer> tags;
    final String slug;
    final String nameOriginal;
    final List<MetacriticPlatform> metacriticPlatforms;
    final bool tba;
    final DateTime updated;
    final String backgroundImage;
    final double rating;
    final int ratingTop;
    final List<Rating> ratings;
    final Map<String, int> reactions;
    final int added;
    final AddedByStatus addedByStatus;
    final int playtime;
    final int screenshotsCount;
    final int moviesCount;
    final int creatorsCount;
    final int achievementsCount;
    final int parentAchievementsCount;
    final String redditUrl;
    final String redditName;
    final String redditDescription;
    final String redditLogo;
    final int redditCount;
    final int twitchCount;
    final int youtubeCount;
    final int reviewsTextCount;
    final int ratingsCount;
    final int suggestionsCount;
    final List<String> alternativeNames;
    final String metacriticUrl;
    final int parentsCount;
    final int additionsCount;
    final int gameSeriesCount;
    final dynamic userGame;
    final int reviewsCount;
    final String saturatedColor;
    final String dominantColor;
    final List<ParentPlatform> parentPlatforms;
    final List<PlatformElement> platforms;
    final List<Developer> publishers;
    final EsrbRating esrbRating;
    final dynamic clip;
    final String descriptionRaw;

    Model({
        required this.id,
        required this.slug,
        required this.name,
        required this.nameOriginal,
        required this.description,
        required this.metacritic,
        required this.metacriticPlatforms,
        required this.released,
        required this.tba,
        required this.updated,
        required this.backgroundImage,
        required this.backgroundImageAdditional,
        required this.website,
        required this.rating,
        required this.ratingTop,
        required this.ratings,
        required this.reactions,
        required this.added,
        required this.addedByStatus,
        required this.playtime,
        required this.screenshotsCount,
        required this.moviesCount,
        required this.creatorsCount,
        required this.achievementsCount,
        required this.parentAchievementsCount,
        required this.redditUrl,
        required this.redditName,
        required this.redditDescription,
        required this.redditLogo,
        required this.redditCount,
        required this.twitchCount,
        required this.youtubeCount,
        required this.reviewsTextCount,
        required this.ratingsCount,
        required this.suggestionsCount,
        required this.alternativeNames,
        required this.metacriticUrl,
        required this.parentsCount,
        required this.additionsCount,
        required this.gameSeriesCount,
        required this.userGame,
        required this.reviewsCount,
        required this.saturatedColor,
        required this.dominantColor,
        required this.parentPlatforms,
        required this.platforms,
        required this.stores,
        required this.developers,
        required this.genres,
        required this.tags,
        required this.publishers,
        required this.esrbRating,
        required this.clip,
        required this.descriptionRaw,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        nameOriginal: json["name_original"],
        description: json["description"],
        metacritic: json["metacritic"],
        metacriticPlatforms: List<MetacriticPlatform>.from(json["metacritic_platforms"].map((x) => MetacriticPlatform.fromJson(x))),
        released: DateTime.parse(json["released"]),
        tba: json["tba"],
        updated: DateTime.parse(json["updated"]),
        backgroundImage: json["background_image"],
        backgroundImageAdditional: json["background_image_additional"],
        website: json["website"],
        rating: json["rating"]?.toDouble(),
        ratingTop: json["rating_top"],
        ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        reactions: Map.from(json["reactions"]).map((k, v) => MapEntry<String, int>(k, v)),
        added: json["added"],
        addedByStatus: AddedByStatus.fromJson(json["added_by_status"]),
        playtime: json["playtime"],
        screenshotsCount: json["screenshots_count"],
        moviesCount: json["movies_count"],
        creatorsCount: json["creators_count"],
        achievementsCount: json["achievements_count"],
        parentAchievementsCount: json["parent_achievements_count"],
        redditUrl: json["reddit_url"],
        redditName: json["reddit_name"],
        redditDescription: json["reddit_description"],
        redditLogo: json["reddit_logo"],
        redditCount: json["reddit_count"],
        twitchCount: json["twitch_count"],
        youtubeCount: json["youtube_count"],
        reviewsTextCount: json["reviews_text_count"],
        ratingsCount: json["ratings_count"],
        suggestionsCount: json["suggestions_count"],
        alternativeNames: List<String>.from(json["alternative_names"].map((x) => x)),
        metacriticUrl: json["metacritic_url"],
        parentsCount: json["parents_count"],
        additionsCount: json["additions_count"],
        gameSeriesCount: json["game_series_count"],
        userGame: json["user_game"],
        reviewsCount: json["reviews_count"],
        saturatedColor: json["saturated_color"],
        dominantColor: json["dominant_color"],
        parentPlatforms: List<ParentPlatform>.from(json["parent_platforms"].map((x) => ParentPlatform.fromJson(x))),
        platforms: List<PlatformElement>.from(json["platforms"].map((x) => PlatformElement.fromJson(x))),
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
        developers: List<Developer>.from(json["developers"].map((x) => Developer.fromJson(x))),
        genres: List<Developer>.from(json["genres"].map((x) => Developer.fromJson(x))),
        tags: List<Developer>.from(json["tags"].map((x) => Developer.fromJson(x))),
        publishers: List<Developer>.from(json["publishers"].map((x) => Developer.fromJson(x))),
        esrbRating: EsrbRating.fromJson(json["esrb_rating"]),
        clip: json["clip"],
        descriptionRaw: json["description_raw"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "name_original": nameOriginal,
        "description": description,
        "metacritic": metacritic,
        "metacritic_platforms": List<dynamic>.from(metacriticPlatforms.map((x) => x.toJson())),
        "released": "${released.year.toString().padLeft(4, '0')}-${released.month.toString().padLeft(2, '0')}-${released.day.toString().padLeft(2, '0')}",
        "tba": tba,
        "updated": updated.toIso8601String(),
        "background_image": backgroundImage,
        "background_image_additional": backgroundImageAdditional,
        "website": website,
        "rating": rating,
        "rating_top": ratingTop,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "reactions": Map.from(reactions).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "added": added,
        "added_by_status": addedByStatus.toJson(),
        "playtime": playtime,
        "screenshots_count": screenshotsCount,
        "movies_count": moviesCount,
        "creators_count": creatorsCount,
        "achievements_count": achievementsCount,
        "parent_achievements_count": parentAchievementsCount,
        "reddit_url": redditUrl,
        "reddit_name": redditName,
        "reddit_description": redditDescription,
        "reddit_logo": redditLogo,
        "reddit_count": redditCount,
        "twitch_count": twitchCount,
        "youtube_count": youtubeCount,
        "reviews_text_count": reviewsTextCount,
        "ratings_count": ratingsCount,
        "suggestions_count": suggestionsCount,
        "alternative_names": List<dynamic>.from(alternativeNames.map((x) => x)),
        "metacritic_url": metacriticUrl,
        "parents_count": parentsCount,
        "additions_count": additionsCount,
        "game_series_count": gameSeriesCount,
        "user_game": userGame,
        "reviews_count": reviewsCount,
        "saturated_color": saturatedColor,
        "dominant_color": dominantColor,
        "parent_platforms": List<dynamic>.from(parentPlatforms.map((x) => x.toJson())),
        "platforms": List<dynamic>.from(platforms.map((x) => x.toJson())),
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
        "developers": List<dynamic>.from(developers.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "publishers": List<dynamic>.from(publishers.map((x) => x.toJson())),
        "esrb_rating": esrbRating.toJson(),
        "clip": clip,
        "description_raw": descriptionRaw,
    };
}

class AddedByStatus {
    final int yet;
    final int owned;
    final int beaten;
    final int toplay;
    final int dropped;
    final int playing;

    AddedByStatus({
        required this.yet,
        required this.owned,
        required this.beaten,
        required this.toplay,
        required this.dropped,
        required this.playing,
    });

    factory AddedByStatus.fromJson(Map<String, dynamic> json) => AddedByStatus(
        yet: json["yet"],
        owned: json["owned"],
        beaten: json["beaten"],
        toplay: json["toplay"],
        dropped: json["dropped"],
        playing: json["playing"],
    );

    Map<String, dynamic> toJson() => {
        "yet": yet,
        "owned": owned,
        "beaten": beaten,
        "toplay": toplay,
        "dropped": dropped,
        "playing": playing,
    };
}

class Developer {
    final int id;
    final String name;
    final String slug;
    final int gamesCount;
    final String imageBackground;
    final String domain;
    final Language language;

    Developer({
        required this.id,
        required this.name,
        required this.slug,
        required this.gamesCount,
        required this.imageBackground,
        required this.domain,
        required this.language,
    });

    factory Developer.fromJson(Map<String, dynamic> json) => Developer(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
        domain: json["domain"],
        language: languageValues.map[json["language"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "games_count": gamesCount,
        "image_background": imageBackground,
        "domain": domain,
        "language": languageValues.reverse[language],
    };
}

enum Language {
    ENG
}

final languageValues = EnumValues({
    "eng": Language.ENG
});

class EsrbRating {
    final int id;
    final String name;
    final String slug;

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

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class MetacriticPlatform {
    final int metascore;
    final String url;
    final MetacriticPlatformPlatform platform;

    MetacriticPlatform({
        required this.metascore,
        required this.url,
        required this.platform,
    });

    factory MetacriticPlatform.fromJson(Map<String, dynamic> json) => MetacriticPlatform(
        metascore: json["metascore"],
        url: json["url"],
        platform: MetacriticPlatformPlatform.fromJson(json["platform"]),
    );

    Map<String, dynamic> toJson() => {
        "metascore": metascore,
        "url": url,
        "platform": platform.toJson(),
    };
}

class MetacriticPlatformPlatform {
    final int platform;
    final String name;
    final String slug;

    MetacriticPlatformPlatform({
        required this.platform,
        required this.name,
        required this.slug,
    });

    factory MetacriticPlatformPlatform.fromJson(Map<String, dynamic> json) => MetacriticPlatformPlatform(
        platform: json["platform"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "name": name,
        "slug": slug,
    };
}

class ParentPlatform {
    final EsrbRating platform;

    ParentPlatform({
        required this.platform,
    });

    factory ParentPlatform.fromJson(Map<String, dynamic> json) => ParentPlatform(
        platform: EsrbRating.fromJson(json["platform"]),
    );

    Map<String, dynamic> toJson() => {
        "platform": platform.toJson(),
    };
}

class PlatformElement {
    final PlatformPlatform platform;
    final DateTime releasedAt;
    final Requirements requirements;

    PlatformElement({
        required this.platform,
        required this.releasedAt,
        required this.requirements,
    });

    factory PlatformElement.fromJson(Map<String, dynamic> json) => PlatformElement(
        platform: PlatformPlatform.fromJson(json["platform"]),
        releasedAt: DateTime.parse(json["released_at"]),
        requirements: Requirements.fromJson(json["requirements"]),
    );

    Map<String, dynamic> toJson() => {
        "platform": platform.toJson(),
        "released_at": "${releasedAt.year.toString().padLeft(4, '0')}-${releasedAt.month.toString().padLeft(2, '0')}-${releasedAt.day.toString().padLeft(2, '0')}",
        "requirements": requirements.toJson(),
    };
}

class PlatformPlatform {
    final int id;
    final String name;
    final String slug;
    final dynamic image;
    final dynamic yearEnd;
    final int yearStart;
    final int gamesCount;
    final String imageBackground;

    PlatformPlatform({
        required this.id,
        required this.name,
        required this.slug,
        required this.image,
        required this.yearEnd,
        required this.yearStart,
        required this.gamesCount,
        required this.imageBackground,
    });

    factory PlatformPlatform.fromJson(Map<String, dynamic> json) => PlatformPlatform(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        yearEnd: json["year_end"],
        yearStart: json["year_start"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "year_end": yearEnd,
        "year_start": yearStart,
        "games_count": gamesCount,
        "image_background": imageBackground,
    };
}

class Requirements {
    final String minimum;
    final String recommended;

    Requirements({
        required this.minimum,
        required this.recommended,
    });

    factory Requirements.fromJson(Map<String, dynamic> json) => Requirements(
        minimum: json["minimum"],
        recommended: json["recommended"],
    );

    Map<String, dynamic> toJson() => {
        "minimum": minimum,
        "recommended": recommended,
    };
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

class Store {
    final int id;
    final String url;
    final Developer store;

    Store({
        required this.id,
        required this.url,
        required this.store,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        url: json["url"],
        store: Developer.fromJson(json["store"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "store": store.toJson(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
