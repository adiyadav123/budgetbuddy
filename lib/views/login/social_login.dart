import 'package:budgetbuddy/common_widget/login_buttons.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/email_signin.dart';
import 'package:budgetbuddy/views/login/social_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/img/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 15,
                  ),
                  LoginButton(
                      icon: "assets/img/google.png",
                      iconColor: TColor.gray,
                      textColor: TColor.gray,
                      shadowColor: TColor.white,
                      asset: "assets/img/google_btn.png",
                      title: "Sign up with Google",
                      onPressed: () {
                        _signInWithGoogle();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  LoginButton(
                      icon: "assets/img/github.png",
                      iconColor: TColor.white,
                      shadowColor: TColor.gray80,
                      textColor: TColor.white,
                      asset: "assets/img/apple_btn.png",
                      title: "Sign up with Github",
                      onPressed: () {
                        _signInWithGithub();
                      }),
                  const SizedBox(height: 15),
                  Text("or",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.35), fontSize: 14)),
                  const SizedBox(height: 15),
                  SecondaryButton(
                      title: "Continue without signing up",
                      asset: "assets/img/secondary_btn.png",
                      onPressed: () {
                        Get.to(() => ConfigPage(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 1000));
                      },
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 15),
                  Text(
                      "By registering you agree to our Terms of Use. Learn how we process your data in our Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.gray20,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      FirebaseAuth auth = FirebaseAuth.instance;

      auth.signInWithProvider(googleAuthProvider).then((value) async {
        User? user = value.user;

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Something unexpected occurred. Please sign in again")));

          return Get.to(() => SocialLogin(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000));
        } else {
          var mail = user.email;

          if (mail == null) {
            var box = await Hive.openBox("user");
            box.put("method", "firebase");
            box.put("email", "$mail");
            return Get.to(() => ConfigPage(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 1000));
          }

          var box = await Hive.openBox("user");
          box.put("method", "firebase");
          box.put("email", "$mail");

          Get.to(() => SocialConfigPage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000));
        }
      });
    } catch (e) {
      return print(e);
    }
  }

  _signInWithGithub() async {
    GithubAuthProvider authProvider = GithubAuthProvider();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithProvider(authProvider).then((value) async {
      User? user = value.user;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Something unexpected occurred. Please sign in again")));

        return Get.to(() => SocialLogin(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1000));
      } else {
        var mail = user.email;

        if (mail == null) {
          var box = await Hive.openBox("user");
          box.put("method", "firebase");
          box.put("email", "$mail");
          return Get.to(() => ConfigPage(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 1000));
        }

        var box = await Hive.openBox("user");

        box.put("email", "$mail");
        box.put("method", "firebase");

        Get.to(() => SocialConfigPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1000));
      }
    });
  }
}
