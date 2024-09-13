import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/budgets_row.dart';
import 'package:budgetbuddy/common_widget/custom_arc_180_painter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../settings/settings_view.dart';

class SpendingBudgetsView extends StatefulWidget {
  const SpendingBudgetsView({super.key});

  @override
  State<SpendingBudgetsView> createState() => _SpendingBudgetsViewState();
}

class _SpendingBudgetsViewState extends State<SpendingBudgetsView> {
  List s = [];

  List budgetArr = [
    {
      "name": "Entertainment",
      "icon": "assets/img/netflix_logo.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.secondaryG.value
    },
    {
      "name": "Medicine",
      "icon": "assets/img/medicine.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.secondary50.value
    },
    {
      "name": "Security",
      "icon": "assets/img/camera.png",
      "total_budget": "10000",
      "spend_amount": "0",
      "left_amount": "10000",
      "color": TColor.primary10.value
    },
    {
      "name": "Miscellaneous",
      "icon": "assets/img/housing.png",
      "total_budget": "10000",
      "spend_amount": "5000",
      "left_amount": "5000",
      "color": Colors.yellow.value
    },
    {
      "name": "Food",
      "icon": "assets/img/store.png",
      "total_budget": "60000",
      "spend_amount": "0",
      "left_amount": "60000",
      "color": Colors.blue.value
    }
  ];

  void checkData() async {
    print("checking data");
    var categoryBox = await Hive.openBox("categories");
    var catArr = categoryBox.get("categories");

    if (catArr != null) {
      List<dynamic> categoryList = catArr as List;
      print(categoryList);
    } else {
      print("no categories added");
      categoryBox.put("categories", budgetArr);
      print("categories added");
    }
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35, right: 10),
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsView()));
                      },
                      icon: Image.asset("assets/img/settings.png",
                          width: 25, height: 25, color: TColor.gray30))
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: media.width * 0.5,
                  height: media.width * 0.30,
                  child: CustomPaint(
                    painter: CustomArc180Painter(
                      drwArcs: [
                        ArcValueModel(color: TColor.secondaryG, value: 20),
                        ArcValueModel(color: TColor.secondary, value: 45),
                        ArcValueModel(color: TColor.primary10, value: 70),
                      ],
                      end: 50,
                      width: 12,
                      bgWidth: 8,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "\$82,90",
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "of \$2,0000 budget",
                      style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.border.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your budgets are on tack 👍",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: budgetArr.length,
                itemBuilder: (context, index) {
                  var bObj = budgetArr[index] as Map? ?? {};

                  return BudgetsRow(
                    bObj: bObj,
                    onPressed: () {},
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: DottedBorder(
                  dashPattern: const [5, 4],
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  color: TColor.border.withOpacity(0.1),
                  child: Container(
                    height: 64,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add new category ",
                          style: TextStyle(
                              color: TColor.gray30,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          "assets/img/add.png",
                          width: 12,
                          height: 12,
                          color: TColor.gray30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
