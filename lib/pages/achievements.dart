import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/achievements_model.dart';

class AchievementsPage extends StatefulWidget {
  final int id;
  const AchievementsPage({super.key, required this.id});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  List<Result> achievements = [];
  int pageNumber = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadAchievements();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!isLoading && hasMore) {
          _loadMoreAchievements();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadAchievements() async {
    setState(() {
      isLoading = true;
    });

    try {
      final achievementsModel = await GameApi().fetchAchievements(widget.id, pageNumber);
      setState(() {
        achievements = achievementsModel.first.results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMoreAchievements() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      pageNumber++;
    });

    try {
      final achievementsModel = await GameApi().fetchAchievements(widget.id, pageNumber);
      setState(() {
        achievements.addAll(achievementsModel.first.results);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade700,
      appBar: AppBar(
        title: const Text("Achievements", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: achievements.isEmpty && isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: achievements.length + (isLoading ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                if (index < achievements.length) {
                  var achievement = achievements[index];
                  return Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            achievement.image,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5),
                        AutoSizeText(
                          achievement.name,
                          maxLines: 2,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        Container(width: 50, height: 1, color: Colors.white),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            achievement.description,
                            maxLines: 3,
                            minFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (isLoading) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
    );
  }
}
