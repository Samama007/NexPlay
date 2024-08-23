import 'dart:convert';
import 'package:http/http.dart' as http;
import 'game.dart';

class ApiService {
  final String baseUrl = "https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e";

  Future<List<Game>> fetchGames() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List gamesData = jsonData['results'];
      return gamesData.map((game) => Game.fromJson(game)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }
}
