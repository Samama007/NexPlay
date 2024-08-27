import 'package:http/http.dart' as http;
import 'dart:convert';

class GameApi {
  static const String apiKey = 'b4c477df733b421d8b4d897023fb0f6e';
  static const String baseUrl = 'https://api.rawg.io/api/games';

  static Future<List<dynamic>> fetchGames() async {
    final url = Uri.parse('$baseUrl?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load games');
    }
  }
}
