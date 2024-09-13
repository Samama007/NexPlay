class GameEg {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;
  final List<Store> stores;

  GameEg({required this.id, required this.name, required this.backgroundImage, required this.rating, required this.stores});

  factory GameEg.fromJson(Map<String, dynamic> json) {
    return GameEg(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      rating: json['rating'].toDouble(),
      stores: json['stores'].map<Store>((store) => Store.fromJson(store)).toList(),
    );
  }
}

class Store {
    final int id;
    // final Genre store;

    Store({
        required this.id,
        // required this.store,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        // store: Genre.fromJson(json["store"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "store": store.toJson(),
    };
}