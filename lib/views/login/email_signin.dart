import 'package:budgetbuddy/common_widget/login_buttons.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/config.dart';
import 'package:budgetbuddy/views/login/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String password = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.gray80,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(
                      "assets/img/app_logo.png",
                      width: media.width * 0.5,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 200),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("E-mail address",
                            style: TextStyle(
                              color: TColor.gray50,
                              fontSize: 14,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 48,
                          decoration: BoxDecoration(
                            color: TColor.gray60.withOpacity(0.1),
                            border: Border.all(
                              color: TColor.gray70,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                email = text;
                              });
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15),
                            ),
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style: TextStyle(
                              color: TColor.gray50,
                              fontSize: 14,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 48,
                          decoration: BoxDecoration(
                            color: TColor.gray60.withOpacity(0.1),
                            border: Border.all(
                              color: TColor.gray70,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15),
                            ),
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                        "Use 8 characters with a mix of letters, numbers & symbols",
                        style: TextStyle(
                          color: TColor.gray50,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        title: "Sign Up",
                        onPressed: () {
                          _getStarted();
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                    Text("Already have an an account? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColor.gray50,
                          fontSize: 15,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    SecondaryButton(
                        title: "Sign in with Email",
                        asset: "assets/img/secondary_btn.png",
                        onPressed: () {
                          Get.to(() => SignIn(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 1000));
                        },
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getStarted() async {
    if (password.length < 8) {
      Get.snackbar(
          "Password too short", "Password must be at least 8 characters",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColor.gray80,
          colorText: TColor.white);
    } else if (email.contains("@") == false ||
        email.contains(".com") == false) {
      Get.snackbar("Invalid email", "Please enter a valid email address",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColor.gray80,
          colorText: TColor.white);
    } else {
      var box = await Hive.openBox("user");
      box.put("email", email);
      box.put("password", password);
      box.put("method", "hive");

      var auth = FirebaseAuth.instance;
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
       return Get.snackbar("Uh oh!", e.code,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: TColor.gray80,
            colorText: TColor.white);
      } catch (e) {
        return print(e);
      }

      Get.to(() => ConfigPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1000));
    }
  }
}
