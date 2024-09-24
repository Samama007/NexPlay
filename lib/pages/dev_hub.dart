import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/dev_model.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  @override
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  final GameApi _apiService = GameApi();
  final List<Result> _developers = [];
  final Map<int, DescriptionModel> _gameDescriptions = {};
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;
  final bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadDevelopers();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadDevelopers() async {
    if (_isLoading || _loadingMore) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final devModel = await _apiService.fetchDevelopers(_currentPage);
      setState(() {
        _developers.addAll(devModel.results);
        _currentPage++;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDescription(int gameId) async {
    if (_gameDescriptions.containsKey(gameId)) return;
    try {
      final gameDescription = await _apiService.fetchDescription(gameId);
      setState(() {
        _gameDescriptions[gameId] = gameDescription;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_loadingMore) {
      _loadDevelopers();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text('Developer', style: TextStyle(color: foregroundColor, fontSize: 60, fontWeight: FontWeight.w900)),
            Text('Showcase', style: TextStyle(color: foregroundColor, fontSize: 40, fontWeight: FontWeight.w900)),
            Text("''Master's of Play & their divine creations!''", style: TextStyle(color: foregroundColor, fontSize: 20, fontStyle: FontStyle.italic)),
            const SizedBox(height: 50),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: foregroundColor))
                  : ListView.builder(
                      itemCount: _developers.length + (_loadingMore ? 1 : 0),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < _developers.length) {
                          final developer = _developers[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(developer.name, style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: developer.games.length,
                                  itemBuilder: (context, gameIndex) {
                                    final game = developer.games[gameIndex];
                                    if (!_gameDescriptions.containsKey(game.id)) {
                                      _loadDescription(game.id);
                                    }
                                    final gameDescription = _gameDescriptions[game.id];
                                    return Container(
                                      width: 200,
                                      decoration: const BoxDecoration(),
                                      child: Skeletonizer(
                                        effect: ShimmerEffect(
                                          baseColor: Colors.grey.shade400,
                                          highlightColor: Colors.grey.shade50,
                                          duration: const Duration(seconds: 1),
                                        ),
                                        enabled: gameDescription == null,
                                        child: InkWell(
                                          // onTap: () => Get.to(() => GameDetail(game: game, price: price)),
                                          child: Column(
                                            children: [
                                              gameDescription == null ? Container(height: 230, width: 195, color: Colors.grey.shade300) : ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(gameDescription.backgroundImage!, height: 230, width: 190, fit: BoxFit.cover)),
                                              const SizedBox(height: 10),
                                              gameDescription == null
                                                  ? Text('Loading...', style: TextStyle(color: foregroundColor))
                                                  : Text(
                                                      game.name,
                                                      style: TextStyle(color: foregroundColor, fontSize: 18, fontWeight: FontWeight.bold),
                                                      textAlign: TextAlign.center,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        } else {
                          return _loadingMore ? Center(child: CircularProgressIndicator(color: foregroundColor)) : Container();
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
