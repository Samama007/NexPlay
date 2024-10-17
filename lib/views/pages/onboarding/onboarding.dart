import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nexplay/views/pages/authentication/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) {
            if (value == 2) {
              setState(() {
                isLastPage = true;
              });
            } else {
              setState(() {
                isLastPage = false;
              });
            }
          },
          children: [
            Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/intro1.svg', height: 400),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Browse Millions of games from a massive Library.", style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    )),
                  ],
                )),
            Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/animations/intro2.json',
                      repeat: true,
                      height: 400,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Customize your profile and keep track of your achievements.", style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    )),
                  ],
                )),
            Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/animations/intro3.json',
                      repeat: true,
                      height: 370,
                      reverse: true,
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("From articles to editorial reviews, we've got you covered. \nJoin NexPlay today!", style: TextStyle(color: foregroundColor, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    )),
                  ],
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment(0, 0.8),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: JumpingDotEffect(dotColor: foregroundColor, activeDotColor: tertiaryColor),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(200, 50)),
                backgroundColor: WidgetStatePropertyAll(foregroundColor),
                foregroundColor: WidgetStatePropertyAll(backgroundColor),
              ),
              onPressed: () async {
                if (isLastPage) {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setBool('firstTime', false);
                  Get.offAll(LoginPage());
                } else {
                  _controller.jumpToPage(2);
                }
              },
              child: Text(isLastPage ? 'GET STARTED' : 'SKIP', style: TextStyle(color: backgroundColor, fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 40),
          ],
        ),
      ]),
    );
  }
}
