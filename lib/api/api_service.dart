import 'package:http/http.dart' as http;
import 'package:nexplay/models/description_model.dart';
import 'dart:convert';
import 'package:nexplay/models/game_model.dart';

class GameApi {
  Future<List<GameModel>> fetchGames() async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<GameModel> games = (data['results'] as List).map((gameJson) => GameModel.fromJson(gameJson)).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  Future<List<DescriptionModel>> fetchdetails(int id) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games/$id?key=b4c477df733b421d8b4d897023fb0f6e'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<DescriptionModel> description = [
        DescriptionModel.fromJson(data)
      ];
      return description;
    } else {
      throw Exception('Failed to load games');
    }
  }
}
