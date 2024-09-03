import 'package:http/http.dart' as http;
import 'package:nexplay/models/my_category_description.dart';
import 'package:nexplay/models/my_categories_model.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'dart:convert';
import 'package:nexplay/models/my_game_model.dart';

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

  Future<DescriptionModel> fetchDescription(int id) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games/$id?key=b4c477df733b421d8b4d897023fb0f6e'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DescriptionModel description = 
        DescriptionModel.fromJson(data)
      ;
      return description;
    } else {
      throw Exception('Failed to load game details');
    }
  }

  Future<List<CategoriesModel>> fetchCategory() async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/genres?key=b4c477df733b421d8b4d897023fb0f6e'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<CategoriesModel> category = [
        CategoriesModel.fromJson(data)
      ];
      return category;
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  // Future<CategoryDescriptionModel> fetchCateDetails(int id) async {
  //   final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&genres=$id'));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     CategoryDescriptionModel categorydescription = 
  //       CategoryDescriptionModel.fromJson(data)
  //     ;
  //     return categorydescription;
  //   } else {
  //     throw Exception('Failed to load games');
  //   }
  // }

  Future<List<CategoryDescriptionModel>> fetchCateDetails(int id) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&genres=$id'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<CategoryDescriptionModel> categorydescription = (data['results'] as List).map((gameJson) => CategoryDescriptionModel.fromJson(gameJson)).toList();
      return categorydescription;
    } else {
      throw Exception('Failed to load Category details');
    }
  }
}
