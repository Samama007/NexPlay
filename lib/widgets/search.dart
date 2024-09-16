import 'dart:async'; // Import Timer
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/models/my_game_model.dart' as gamemodel;
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/models/search_mode.dart';
import 'package:nexplay/pages/game_detail.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchBarr extends StatefulWidget {
  const SearchBarr({super.key});

  @override
  State<SearchBarr> createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  List<SearchModel> games = [];
  List<String> suggestions = [];
  Timer? _debounce;
  final FocusNode focus = FocusNode();

  Future<void> searchGames(String query) async {
    final response = await http.get(Uri.parse('https://api.rawg.io/api/games?key=b4c477df733b421d8b4d897023fb0f6e&search=$query'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List result = data['results'];
      setState(() {
        games = result.map((gameJson) => SearchModel.fromJson(gameJson)).toList();
        suggestions = games.map((game) => game.name).toList();
      });
    } else {
      throw Exception('API error');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () {
      if (query.isNotEmpty && query.length > 3) {
        searchGames(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: SearchField(
          suggestions: suggestions
              .map(
                (gameName) => SearchFieldListItem(
                  gameName,
                  child: searchChild(gameName),
                ),
              )
              .toList(),
          onSearchTextChanged: (query) {
            _onSearchChanged(query);
            return suggestions.map((gameName) => SearchFieldListItem<String>(gameName, child: searchChild(gameName))).toList();
          },
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
          suggestionState: Suggestion.hidden,
          suggestionStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontStyle: FontStyle.normal),
          onTap: () {
            FocusScope.of(context).focusedChild;
          },
          onSuggestionTap: (value) {
            //price
            PriceModel priceModel = PriceModel();
            Random random = Random();
            int randomIndex = random.nextInt(100);
            String price = priceModel.price[randomIndex].toString();
            String selectedGameName = value.searchKey;
            int index = games.indexWhere((game) => game.name == selectedGameName);
            Get.to(() => GameDetail(
                  game: gamemodel.GameModel(
                    id: games[index].id,
                    name: games[index].name,
                    backgroundImage: games[index].backgroundImage!,
                    released: games[index].released!,
                    playtime: games[index].playtime!,
                    ratingsCount: games[index].ratingsCount!,
                    rating: games[index].rating!,
                    shortScreenshots: games[index].shortScreenshots.map((screenshot) => gamemodel.ShortScreenshot(id: screenshot.id, image: screenshot.image!)).toList(),
                    esrbRating: gamemodel.EsrbRating(
                      id: 7,
                      name: 'Mature',
                      slug: '6.7',
                    ),
                  ),
                  price: price,
                ));
          },
          hint: 'Search for a game...',
          searchInputDecoration: SearchInputDecoration(
            hintText: 'Search for a game...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          emptyWidget: const SizedBox.shrink()),
    );
  }

  // Helper widget to show game suggestions
  Widget searchChild(String gameName) {
    final game = games.firstWhere((g) => g.name == gameName);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Image.network(game.backgroundImage),
            Text(game.name),
          ],
        ),
      ),
    );
  }
}
