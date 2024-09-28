import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:nexplay/models/user_model.dart';
// import 'package:nexplay/util/theme.dart';
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
  double userRating = 0;
  TextEditingController reviewController = TextEditingController();

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

  void submitReview() {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    if (reviewController.text.isNotEmpty && userRating > 0) {
      setState(() {
        description!.ratings.add(Rating(id: 23, title: reviewController.text, count: 234, percent: (userRating / 5) * 100));
      });
      reviewController.clear();
      setState(() {
        userRating = 0;
      });
    } else {
      Get.snackbar(
        backgroundColor: foregroundColor,
        colorText: backgroundColor,
        'Error',
        'Please provide a rating and a review.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: Get.height * 0.08,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: foregroundColor, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? _buildSkeletonList(backgroundColor, foregroundColor)
                  : description!.ratings.isEmpty
                      ? Center(child: Text('No ratings yet...', style: TextStyle(color: foregroundColor, fontSize: 25, fontWeight: FontWeight.w500)))
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          color: backgroundColor,
                          child: ListView.builder(
                            itemCount: description!.ratings.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _buildRatingCard(index, backgroundColor, foregroundColor);
                            },
                          ),
                        ),
            ),
            SizedBox(height: 180, child: _buildReviewInput(foregroundColor, backgroundColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewInput(Color foregroundColor, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar(
                filledIcon: Icons.star,
                isHalfAllowed: true,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                initialRating: userRating,
                maxRating: 5,
                size: 35,
                onRatingChanged: (rating) {
                  setState(() {
                    userRating = rating;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: TextField(
              cursorColor: foregroundColor,
              style: TextStyle(color: foregroundColor, fontSize: 16, fontWeight: FontWeight.w400),
              controller: reviewController,
              decoration: InputDecoration(
                hintText: 'Write your review...',
                hintStyle: TextStyle(color: foregroundColor),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: foregroundColor.withOpacity(0.1),
              ),
              maxLines: 3,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(foregroundColor), foregroundColor: WidgetStatePropertyAll(backgroundColor)),
            onPressed: submitReview,
            child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: backgroundColor)),
          ),
        ],
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

  Widget _buildRatingCard(int index, Color backgroundColor, Color foregroundColor) {
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
              ],
            ),
            const SizedBox(height: 8),
            RatingBar.readOnly(
              filledIcon: Icons.star,
              isHalfAllowed: true,
              filledColor: backgroundColor,
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
