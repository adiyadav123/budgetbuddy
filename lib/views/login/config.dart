import 'package:budgetbuddy/common_widget/login_buttons.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../common/color_extension.dart';
import '../../common_widget/secondary_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  void checkUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      Get.to(() => HomeView(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1000));
    }
  }

  @override
  void initState() {
    super.initState();

    checkUser();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  String budget = "";
  String name = "";

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
                        Text("Name",
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
                                name = text;
                              });
                            },
                            controller: nameController,
                            keyboardType: TextInputType.name,
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
                        Text("Monthly Budget ₹",
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
                                budget = text;
                                budgetController.text =
                                    NumberFormat.decimalPattern().format(
                                        int.parse(text.replaceAll(',', '')));
                                // Set the cursor at the end of the text.
                                budgetController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: budgetController.text.length));
                              });
                            },
                            controller: budgetController,
                            keyboardType: TextInputType.number,
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
                    SizedBox(
                      height: media.height * 0.4,
                    ),
                    PrimaryButton(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        title: "Get Started",
                        onPressed: () {
                          _getStarted();
                        }),
                    const SizedBox(
                      height: 80,
                    ),
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
    if (budget.isEmpty || name.isEmpty) {
      Get.snackbar(
          "Budget is empty", "Please enter your name and budget to continue",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: TColor.gray80,
          colorText: TColor.white);
    } else {
      var box = await Hive.openBox("user");
      box.put("name", name);
      box.put("budget", budget);
      box.put("method", "hive");
      box.put("isSignedIn", "true");
    }
  }
}
