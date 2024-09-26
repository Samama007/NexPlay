import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:nexplay/models/user_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RatingsPage extends StatefulWidget {
  final int id;
  const RatingsPage({super.key, required this.id});

  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  GameApi gameApi = GameApi();
  DescriptionModel? description;
  bool isLoading = true;
  MyUser? myUser;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    DescriptionModel fetchedDetails = await gameApi.fetchDescription(widget.id);
    MyUser fetchedUsers = await gameApi.fetchUsers();
    setState(() {
      description = fetchedDetails;
      myUser = fetchedUsers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    Object? selectedValue;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        toolbarHeight: Get.height * 0.08,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: foregroundColor, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? _buildSkeletonList(backgroundColor, foregroundColor)
          : description!.ratings.isEmpty
              ? Center(child: Text('No ratings yet...', style: TextStyle(color: foregroundColor, fontSize: 25, fontWeight: FontWeight.w500)))
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                  height: MediaQuery.of(context).size.height,
                  color: backgroundColor,
                  child: ListView.builder(
                    itemCount: description!.ratings.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildRatingCard(index, backgroundColor, foregroundColor, tertiaryColor, selectedValue);
                    },
                  ),
                ),
    );
  }

  Widget _buildSkeletonList(Color backgroundColor, Color foregroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 5),
      color: backgroundColor,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Skeletonizer(
                        enabled: true,
                        effect: ShimmerEffect(
                          baseColor: backgroundColor,
                          highlightColor: foregroundColor,
                          duration: const Duration(seconds: 1),
                        ),
                        child: const CircleAvatar(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Skeletonizer(
                          enabled: true,
                          effect: ShimmerEffect(
                            baseColor: backgroundColor,
                            highlightColor: foregroundColor,
                            duration: const Duration(seconds: 1),
                          ),
                          child: Text(BoneMock.subtitle),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Skeletonizer(
                    enabled: true,
                    effect: ShimmerEffect(
                      baseColor: backgroundColor,
                      highlightColor: foregroundColor,
                      duration: const Duration(seconds: 1),
                    ),
                    child: RatingBar.readOnly(
                      filledIcon: Icons.star,
                      isHalfAllowed: true,
                      filledColor: backgroundColor,
                      halfFilledIcon: Icons.star_half_sharp,
                      emptyIcon: Icons.star_border,
                      initialRating: 0,
                      maxRating: 5,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Skeletonizer(
                    enabled: true,
                    effect: ShimmerEffect(
                      baseColor: backgroundColor,
                      highlightColor: foregroundColor,
                      duration: const Duration(seconds: 1),
                    ),
                    child: Text(BoneMock.subtitle),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRatingCard(int index, Color backgroundColor, Color foregroundColor, Color tertiaryColor, Object? selectedValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: foregroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    myUser!.results[index].picture.thumbnail,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${myUser!.results[index].name.first} ${myUser!.results[index].name.last}',
                    style: TextStyle(color: backgroundColor),
                  ),
                ),
                DropdownButton(
                  value: selectedValue,
                  icon: Icon(Icons.more_vert_rounded, color: backgroundColor),
                  style: TextStyle(color: backgroundColor),
                  underline: Container(color: backgroundColor),
                  items: [
                    DropdownMenuItem(
                      value: 'Report',
                      child: Text('Flag as Inappropiate', style: TextStyle(color: foregroundColor)),
                      onTap: () {
                        Get.snackbar(
                          'Thank You',
                          'Review Flagged as Inappropriate',
                          padding: const EdgeInsets.all(5),
                          titleText: Text(
                            'Thank You',
                            style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w700, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          messageText: Text(
                            'Review Flagged as Inappropriate',
                            style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w400, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: foregroundColor,
                          duration: const Duration(seconds: 3),
                          isDismissible: true,
                          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 15,
                          snackStyle: SnackStyle.FLOATING,
                        );
                      },
                    ),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            RatingBar.readOnly(
              filledIcon: Icons.star,
              isHalfAllowed: true,
              filledColor: backgroundColor,
              halfFilledColor: tertiaryColor,
              halfFilledIcon: Icons.star_half_sharp,
              emptyIcon: Icons.star_border,
              initialRating: (description!.ratings[index].percent / 100) * 5,
              maxRating: 5,
              size: 35,
            ),
            const SizedBox(height: 8),
            Text(
              '"${description!.ratings[index].title.toUpperCase()}"',
              style: TextStyle(color: backgroundColor, fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
