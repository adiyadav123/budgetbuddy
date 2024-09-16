import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/common_widget/secondary_button.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/social_login.dart';
import 'package:budgetbuddy/views/login/social_signin.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  double _scale = 1.0;

  void checkUser() async {
    print("checking user");
    var box = await Hive.openBox("user");
    if (box.get("budget") != null) {
      Get.to(() => MainTabView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500));
    }
  }

  void zoomOut() {
    setState(() {
      _scale = 1.0;
    });
  }

  void zoomIn() {
    setState(() {
      _scale = 0.9;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/img/welcome_screen.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/img/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  Text(
                    "Smooth management at your fingertips, track your expenses with ease. Stay on top, stay within budget.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Inter", color: TColor.white, fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                      title: "Get Started",
                      onPressed: () {
                        Get.to(() => SocialLogin(),
                            transition: Transition.leftToRightWithFade,
                            duration: const Duration(milliseconds: 1000));
                      },
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 10),
                  SecondaryButton(
                      title: "I have an account",
                      asset: "assets/img/secondary_btn.png",
                      onPressed: () {
                        Get.to(() => SocialSignIn(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 1000));
                      },
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
