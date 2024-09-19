import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/achievements_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Achievements", style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: achievements.isEmpty && isLoading
          ? GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Skeletonizer(
                  effect: ShimmerEffect(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade50,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), child: Container(height: 120, width: double.infinity, color: Colors.grey.shade800)),
                        const SizedBox(height: 5),
                        AutoSizeText(
                          BoneMock.name,
                          maxLines: 2,
                          minFontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        Container(width: 50, height: 1, color: Colors.black),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            BoneMock.name,
                            maxLines: 3,
                            minFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
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
                    color: tertiaryColor,
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
                          style: const TextStyle(color: Color(0xFFF1D3B2), fontSize: 18, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        Container(width: 50, height: 1, color: backgroundColor),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            achievement.description,
                            maxLines: 3,
                            minFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Color(0xFFF1D3B2), fontWeight: FontWeight.w400, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (isLoading) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: CircularProgressIndicator(color: foregroundColor),
                  ));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
    );
  }
}
