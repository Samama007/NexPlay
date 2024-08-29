import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nexplay/models/my_model.dart';

class GameApi {
  // static String apiKey = 'b4c477df733b421d8b4d897023fb0f6e';
  // static String baseUrl = 'https://api.rawg.io/api/games';

  // static Future<List<dynamic>> fetchGames() async {
  //   final url = Uri.parse('$baseUrl?key=$apiKey');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final Map data = json.decode(response.body);
  //     return data['results'];
  //   } else {
  //     throw Exception('Failed to load games');
  //   }
  // }

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
}
