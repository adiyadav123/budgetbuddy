import 'package:budgetbuddy/views/main_tab/main_tab_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/primary_button.dart';
import 'package:budgetbuddy/common_widget/round_textfield.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../common_widget/image_button.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtName = TextEditingController();
  int _current = 0;

  List subArrr = [
    {"name": "Entertainment", "icon": "assets/img/netflix_logo.png"},
    {"name": "Medicine", "icon": "assets/img/medicine.png"},
    {"name": "Security", "icon": "assets/img/camera.png"},
    {
      "name": "Miscellaneous",
      "icon": "assets/img/housing.png",
    },
    {"name": "Food", "icon": "assets/img/store.png"}
  ];

  List defaultSubArr = [
    {"name": "Entertainment", "icon": "assets/img/netflix_logo.png"},
    {"name": "Medicine", "icon": "assets/img/medicine.png"},
    {"name": "Security", "icon": "assets/img/camera.png"},
    {
      "name": "Miscellaneous",
      "icon": "assets/img/housing.png",
    },
    {"name": "Food", "icon": "assets/img/store.png"}
  ];

  double amountVal = 10;

  TextEditingController txtAmount = TextEditingController();

  void checkCurrentStat() async {
    var box = await Hive.openBox("user");
    var budget = box.get("budget");
    var totalSpent = await Hive.openBox("totalSpent");
    var categories = await Hive.openBox("categories");
    var cat = categories.get("categories");
    setState(() {
      subArrr = cat ?? defaultSubArr;
    });

    double total = totalSpent.get("totalSpent") ?? 0;
    int intBudget = int.tryParse(budget.toString()) ?? 0;
    int intTotal = total.toInt();
    double doubleBudget = double.tryParse(budget.toString()) ?? 0;

    print(intBudget);
    print(intTotal);

    if (budget != null) {
      double threshold = 0.75 * doubleBudget;

      if (total >= threshold) {
        Get.snackbar("Heads up!", "You have used 75% of your budget!");

        Get.defaultDialog(
            titleStyle: TextStyle(color: TColor.white),
            backgroundColor: TColor.gray70,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You have used 75% of your budget of ₹ $budget. Consider cutting back in other areas or increase your savings target next month.",
                    style: TextStyle(color: TColor.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    title: "Ok",
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              ),
            ));
      }

      if (total > doubleBudget) {
        Get.snackbar("Uh oh!", "You have exceeded your budget!");

        Get.defaultDialog(
            title: "You have exceeded your budget!",
            content: Column(
              children: [
                Text("You have exceeded your budget of ₹ $budget"),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  title: "Ok",
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkCurrentStat();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset("assets/img/back.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New",
                              style:
                                  TextStyle(color: TColor.gray30, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Add new\n transaction",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.6,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                            autoPlay: false,
                            initialPage: 0,
                            aspectRatio: 1,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.65,
                            enlargeFactor: 0.4,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        itemCount: subArrr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var sObj = subArrr[itemIndex] as Map? ?? {};

                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sObj["icon"],
                                  width: media.width * 0.4,
                                  height: media.width * 0.4,
                                  fit: BoxFit.fitHeight,
                                ),
                                const Spacer(),
                                Text(
                                  sObj["name"],
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: RoundTextField(
                  title: "Title",
                  titleAlign: TextAlign.center,
                  controller: txtName,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: RoundTextField(
                  title: "Description",
                  titleAlign: TextAlign.center,
                  controller: txtDescription,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageButton(
                    image: "assets/img/minus.png",
                    onPressed: () {
                      amountVal -= 10;

                      if (amountVal < 0) {
                        amountVal = 0;
                      }

                      setState(() {});
                    },
                  ),
                  Column(
                    children: [
                      Text(
                        "Cost",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Enter amount"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: TextField(
                                    controller: txtAmount,
                                    keyboardType: TextInputType.number,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            amountVal =
                                                double.parse(txtAmount.text);
                                          });
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Text("Ok")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel")),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: 200,
                          child: Text(
                            "₹ ${amountVal.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 150,
                        height: 1,
                        color: TColor.gray70,
                      )
                    ],
                  ),
                  ImageButton(
                    image: "assets/img/plus.png",
                    onPressed: () {
                      amountVal += 10;

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                title: "Add this txn",
                onPressed: () {
                  _saveData();
                },
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _saveData() async {
    if (txtAmount.text.isNotEmpty && txtDescription.text.isNotEmpty) {
      var subBox = await Hive.openBox("subscription");
      var highestBox = await Hive.openBox("highest");
      var userBox = await Hive.openBox("user");
      var budget = userBox.get("budget");
      double bd = double.tryParse(budget) ?? 0;
      var lowestBox = await Hive.openBox("lowest");
      var totalBox = await Hive.openBox("totalSpent");
      var totalSpent = totalBox.get("totalSpent") ?? "0";
      var totalSpentStr = totalSpent.toString();

      double am = double.tryParse(txtAmount.text) ?? 0;
      double tt = double.tryParse(totalSpentStr) ?? 0;
      double remaingBd = bd - tt;
      if (am > remaingBd) {
        double diff = am - remaingBd;
        return Get.snackbar("Uh oh!",
            "You have exceeded your budget by ₹ $diff. Please reduce the amount, or increase your budget. This will cause an imbalance in your budget.",
            colorText: Colors.red, duration: const Duration(seconds: 10));
      }

      List existingSubArr = subBox.get('arr') ?? [];

      List subArr = [
        {
          "name": txtName.text,
          "icon": subArrr[_current]["icon"],
          "price": amountVal,
          "type": subArrr[_current]["name"],
          "description": txtDescription.text,
          "paymentTime": DateFormat('dd.MM.yyyy').format(DateTime.now())
        }
      ];

      existingSubArr.addAll(subArr);

      subBox.put("arr", existingSubArr);

      var highestVal = highestBox.get('highest') ?? 0;
      var lowestVal = lowestBox.get('lowest') ?? 0;
      var totalVal = totalBox.get('totalSpent') ?? 0;

      if (highestVal < amountVal) {
        highestBox.put('highest', amountVal);
      }
      if (lowestVal == 0 || lowestVal > amountVal) {
        lowestBox.put('lowest', amountVal);
      }

      totalBox.put('totalSpent', amountVal + totalVal);

      Get.snackbar("Added", "Added a new transaction successfully!");

      Get.to(() => const MainTabView(),
          transition: Transition.leftToRightWithFade,
          duration: const Duration(milliseconds: 500));
    } else {
      return Get.snackbar("Uh oh!", "Please fill all the fields");
    }
  }
}
