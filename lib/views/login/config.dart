import 'package:budgetbuddy/common_widget/login_buttons.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:budgetbuddy/views/login/signin.dart';
import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
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
  @override
  void initState() {
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    budgetController.dispose();
    super.dispose();
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
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
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
                    SizedBox(
                      height: media.height * 0.3,
                    ),
                    PrimaryButton(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        title: "Get Started",
                        onPressed: () {
                          _getStarted();
                        }),
                    const SizedBox(
                      height: 10,
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
    print("hey");

    String name = nameController.text;
    String budget = budgetController.text;
    if (budget.isEmpty || name.isEmpty) {
      Get.snackbar(
          "Budget is empty", "Please enter your name and budget to continue",
          colorText: TColor.white);
    } else {
      List subArrr = [
        {
          "name": "Entertainment",
          "icon": "assets/img/netflix_logo.png",
          "total_budget": "${double.parse(budget) * 0.8}",
          "spend_amount": "0",
          "left_amount": "${double.parse(budget) * 0.8}",
          "color": TColor.secondaryG.value
        },
        {
          "name": "Medicine",
          "icon": "assets/img/medicine.png",
          "total_budget": "${double.parse(budget) * 0.3}",
          "spend_amount": "0",
          "left_amount": "${double.parse(budget) * 0.3}",
          "color": TColor.secondary50.value
        },
        {
          "name": "Security",
          "icon": "assets/img/camera.png",
          "total_budget": "${double.parse(budget) * 0.12}",
          "spend_amount": "0",
          "left_amount": "${double.parse(budget) * 0.12}",
          "color": TColor.primary10.value
        },
        {
          "name": "Food & Drinks",
          "icon": "assets/img/housing.png",
          "total_budget": "${double.parse(budget) * 0.10}",
          "spend_amount": "0",
          "left_amount": "${double.parse(budget) * 0.10}",
          "color": Colors.yellow.value
        },
        {
          "name": "Others",
          "icon": "assets/img/store.png",
          "total_budget": "${double.parse(budget) * 0.4}",
          "spend_amount": "0",
          "left_amount": "${double.parse(budget) * 0.4}",
          "color": Colors.blue.value
        }
      ];
      var categoryBox = await Hive.openBox("categories");
      categoryBox.put("categories", subArrr);
      var box = await Hive.openBox("user");
      box.put("name", name);
      box.put("budget", budget);
      box.put("method", "hive");
      box.put("isSignedIn", "true");
      box.put("email", emailController.text);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainTabView()),
          (route) => false);
    }
  }
}
