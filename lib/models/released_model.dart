class ReleasedModel {
  final int id;
  final String name;
  final String backgroundImage;
  final DateTime released;

  ReleasedModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.released,
  });

  factory ReleasedModel.fromJson(Map<String, dynamic> json) {
    return ReleasedModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
      released: DateTime.parse(json['released']),
    );
  }
}
