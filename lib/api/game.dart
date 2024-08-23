class Game {
  final String name;
  final String backgroundImage;
  final double rating;
  final double price;

  Game({required this.name, required this.backgroundImage, required this.rating, required this.price});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'],
      backgroundImage: json['background_image'],
      rating: json['rating'].toDouble(),
      price: (json['price'] != null) ? json['price'].toDouble() : 0.0,
    );
  }
}
