import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nexplay/bin/pagination_model.dart';

class EgApi {
  
  List<GameEg> games = [];
  Future<List<GameEg>> fetchgames(int pageNumber) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&page=$pageNumber'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List result = data['results'];
      games.addAll(result.map((gameJson) => GameEg.fromJson(gameJson)).toList());
      return games;
    } else {
      throw Exception('api error');
    }
  }
}
