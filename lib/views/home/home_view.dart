import 'package:budgetbuddy/views/spending_budgets/spending_budgets_view.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common/color_extension.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../common_widget/custom_arc_painter.dart';
import '../../common_widget/segment_button.dart';
import '../../common_widget/status_button.dart';
import '../../common_widget/subscription_home_row.dart';
import '../../common_widget/upcoming_bill_row.dart';
import '../settings/settings_view.dart';
import '../subscription_info/subscription_info_view.dart';

import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscription = true;
  List subArr = [
    // {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    // {
    //   "name": "Microsoft OneDrive",
    //   "icon": "assets/img/onedrive_logo.png",
    //   "price": "29.99"
    // },
    // {
    //   "name": "YouTube Premium",
    //   "icon": "assets/img/youtube_logo.png",
    //   "price": "18.99"
    // },
    // {
    //   "name": "NetFlix",
    //   "icon": "assets/img/netflix_logo.png",
    //   "price": "15.00"
    // },
    // {
    //   "name": "NetFlix",
    //   "icon": "assets/img/netflix_logo.png",
    //   "price": "15.00"
    // },
  ];

  List bilArr = [
    {"name": "Spotify", "date": DateTime(2023, 07, 25), "price": "5.99"},
    {
      "name": "YouTube Premium",
      "date": DateTime(2023, 07, 25),
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "date": DateTime(2023, 07, 25),
      "price": "29.99"
    },
    {"name": "NetFlix", "date": DateTime(2023, 07, 25), "price": "15.00"}
  ];

  String name = "";
  int budget = 0;
  int subLength = 0;
  int highestSub = 0;
  int lowestSub = 0;
  int totalSpent = 0;
  List subArrHive = [];

  TextEditingController budgetController = TextEditingController();
  void getBox() async {
    var box = await Hive.openBox("user");
    var subBox = await Hive.openBox("subscription");
    var highestBox = await Hive.openBox("highest");
    var lowestBox = await Hive.openBox("lowest");
    var totalSpentt = await Hive.openBox("totalSpent");
    var subAr = subBox.values.toList();

    if (box.get("budget") == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Welcome to Budget Buddy"),
                backgroundColor: TColor.gray70,
                contentTextStyle: TextStyle(color: TColor.white),
                titleTextStyle: TextStyle(color: TColor.white),
                content: TextField(
                  controller: budgetController,
                  decoration: InputDecoration(
                      hintText: "Enter your budget",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                actions: [
                  TextButton(
                      onPressed: () {
                        var box = Hive.box("user");
                        box.put("budget", budgetController.text);
                        Navigator.pop(context);
                      },
                      child: const Text("Set Budget")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"))
                ],
              );
            });
      });
    }

    setState(() {
      name = box.get("name") as String? ?? "";
      budget = int.tryParse(box.get("budget")?.replaceAll(",", "") ?? "0") ?? 0;
      subLength =
          int.tryParse(subBox.length.toString().replaceAll(",", "")) ?? 0;
      highestSub =
          int.tryParse(highestBox.get("highest")?.replaceAll(",", "") ?? "0") ??
              0;
      lowestSub =
          int.tryParse(lowestBox.get("lowest")?.replaceAll(",", "") ?? "0") ??
              0;
      totalSpent =
          int.tryParse(totalSpentt.get("total")?.replaceAll(",", "") ?? "0") ??
              0;
    });
  }

  void setBudgetCustom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Welcome to Budget Buddy"),
              backgroundColor: TColor.gray70,
              contentTextStyle: TextStyle(color: TColor.white),
              titleTextStyle: TextStyle(color: TColor.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              content: TextField(
                controller: budgetController,
                decoration: InputDecoration(
                    hintText: "Enter your budget",
                    hintStyle: TextStyle(color: TColor.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      var box = Hive.box("user");
                      box.put("budget", budgetController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Set Budget")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"))
              ],
            );
          });
    });
  }

  @override
  void initState() {
    super.initState();
    getBox();
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
              height: media.width * 1.1,
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/img/home_bg.png"),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: media.width * 0.05),
                        width: media.width * 0.72,
                        height: media.width * 0.72,
                        child: CustomPaint(
                          painter: CustomArcPainter(
                            end: 220,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsView()));
                                },
                                icon: Image.asset("assets/img/settings.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Image.asset("assets/img/app_logo.png",
                          width: media.width * 0.25, fit: BoxFit.contain),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      GestureDetector(
                        onTap: () {
                          setBudgetCustom();
                        },
                        child: Text(
                          "₹ ${NumberFormat("#,##0").format(budget)}",
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.055,
                      ),
                      Text(
                        "This month bills",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SpendingBudgetsView(),
                              transition: Transition.leftToRightWithFade,
                              duration: Duration(milliseconds: 500));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: TColor.border.withOpacity(0.15),
                            ),
                            color: TColor.gray60.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "See your budget",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: StatusButton(
                                title: "Credits Left",
                                value:
                                    "₹ ${NumberFormat("#,##0").format(budget - totalSpent)}",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Highest Txns",
                                value:
                                    "₹ ${NumberFormat("#,##0").format(highestSub)}",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Lowest Txns",
                                value:
                                    "₹ ${NumberFormat("#,##0").format(lowestSub)}",
                                statusColor: TColor.secondaryG,
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Your transactions",
                      isActive: isSubscription,
                      onTap: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (isSubscription)
              subArr.isEmpty
                  ? Center(
                      child: Text(
                        "No transactions added yet.",
                        style: TextStyle(color: TColor.gray30),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subArr.length,
                      itemBuilder: (context, index) {
                        var sObj = subArr[index] as Map? ?? {};

                        return SubScriptionHomeRow(
                          sObj: sObj,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubscriptionInfoView(sObj: sObj)));
                          },
                        );
                      }),
            if (!isSubscription)
              bilArr.isEmpty
                  ? Center(
                      child: Text(
                        "No transactions added yet.",
                        style: TextStyle(color: TColor.gray30),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bilArr.length,
                      itemBuilder: (context, index) {
                        var sObj = bilArr[index] as Map? ?? {};

                        return UpcomingBillRow(
                          sObj: sObj,
                          onPressed: () {},
                        );
                      }),
          ],
        ),
      ),
    );
  }
}
