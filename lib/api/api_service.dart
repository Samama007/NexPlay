import 'package:http/http.dart' as http;
import 'package:nexplay/models/achievements_model.dart';
import 'package:nexplay/models/bestseller_model.dart';
import 'package:nexplay/models/dev_model.dart';
import 'package:nexplay/models/my_category_description.dart';
import 'package:nexplay/models/my_categories_model.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'dart:convert';
import 'package:nexplay/models/my_game_model.dart';
import 'package:nexplay/models/released_model.dart';
import 'package:nexplay/models/user_model.dart';
// import 'package:nexplay/models/search_mode.dart';

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
      DescriptionModel description = DescriptionModel.fromJson(data);
      return description;
    } else {
      throw Exception('Failed to load game details');
    }
  }

  Future<MyUser> fetchUsers() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      MyUser myUser = MyUser.fromJson(data);
      return myUser;
    } else {
      throw Exception('Failed to load users');
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

  Future<List<CategoryDescriptionModel>> fetchCateDetails(int id, int pageNumber) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&genres=$id&page=$pageNumber'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<CategoryDescriptionModel> categorydescription = (data['results'] as List).map((gameJson) => CategoryDescriptionModel.fromJson(gameJson)).toList();
      return categorydescription;
    } else {
      throw Exception('Failed to load Category details');
    }
  }

  Future<List<AchievementsModel>> fetchAchievements(int id, int page) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games/$id/achievements?key=b4c477df733b421d8b4d897023fb0f6e&page=$page'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<AchievementsModel> achievements = [
        AchievementsModel.fromJson(data)
      ];
      return achievements;
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  Future<DeveloperModel> fetchDevelopers(int page) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/developers?key=b4c477df733b421d8b4d897023fb0f6e&page=$page'));
    if (response.statusCode == 200) {
      return DeveloperModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load developers');
    }
  }

  // Future<SearchModel> searchGames(String query) async {
  //   final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&search=$query'));
  //   if (response.statusCode == 200) {
  //     return SearchModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('API error');
  //   }
  // }

  List<ReleasedModel> released = [];
  Future<List<ReleasedModel>> sortbyreleased() async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&ordering=created'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List result = data['results'];
      released.addAll(result.map((gameJson) => ReleasedModel.fromJson(gameJson)).toList());
      return released;
    } else {
      throw Exception('Failed to load games by release date');
    }
  }

  List<BestsellerModel> bestSeller = [];
  Future<List<BestsellerModel>> sortbyBestSeller() async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&ordering=-metacritic'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List result = data['results'];
      bestSeller.addAll(result.map((gameJson) => BestsellerModel.fromJson(gameJson)).toList());
      return bestSeller;
    } else {
      throw Exception('Failed to load games by bestSeller');
    }
  }
}
