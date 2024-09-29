import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/models/my_game_model.dart' as gamemodel;
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/models/search_mode.dart';
import 'package:nexplay/pages/game_detail.dart';
import 'package:searchfield/searchfield.dart';
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
    Color backgroundColor = Theme.of(context).primaryColor;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: Get.width * 0.8,
      child: SearchField(
          suggestions: suggestions
              .map(
                (gameName) => SearchFieldListItem(
                  gameName,
                  child: searchChild(gameName),
                ),
              )
              .toList(),
          scrollbarDecoration: ScrollbarDecoration(thumbColor: backgroundColor, crossAxisMargin: 3, thickness: 10),
          suggestionsDecoration: SuggestionDecoration(color: Colors.transparent, selectionColor: foregroundColor.withOpacity(0.3)),
          suggestionItemDecoration: BoxDecoration(color: foregroundColor),
          marginColor: Colors.transparent,
          onSearchTextChanged: (query) {
            _onSearchChanged(query);
            return suggestions.map((gameName) => SearchFieldListItem<String>(gameName, child: searchChild(gameName))).toList();
          },
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
          suggestionState: Suggestion.hidden,
          suggestionStyle: TextStyle(color: foregroundColor, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontStyle: FontStyle.normal),
          onTap: () {
            FocusScope.of(context).focusedChild;
          },
          onSuggestionTap: (value) {
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
            hintStyle: TextStyle(color: foregroundColor),
            cursorColor: foregroundColor,
            focusColor: foregroundColor,
            helperStyle: TextStyle(color: foregroundColor),
            searchStyle: TextStyle(color: foregroundColor),
            suffixIcon: Icon(Icons.search_rounded, color: foregroundColor),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: foregroundColor, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: foregroundColor, style: BorderStyle.solid)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          emptyWidget: const SizedBox.shrink()),
    );
  }

  Widget searchChild(String gameName) {
    Color backgroundColor = Theme.of(context).primaryColor;
    final game = games.firstWhere((g) => g.name == gameName);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              game.name,
              style: TextStyle(color: backgroundColor, fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }
}
