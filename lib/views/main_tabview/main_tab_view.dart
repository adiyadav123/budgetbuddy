import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/views/home/home_view.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/img/bottom_bar_bg.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectTab = 0;
                                      currentScreen = HomeView();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/img/home.png",
                                    height: 20,
                                    width: 20,
                                    color: selectTab == 0
                                        ? TColor.white
                                        : TColor.gray30,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectTab = 1;
                                      currentScreen = Container();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/img/budgets.png",
                                    height: 20,
                                    width: 20,
                                    color: selectTab == 1
                                        ? TColor.white
                                        : TColor.gray30,
                                  )),
                              SizedBox(width: 50),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectTab = 2;
                                      currentScreen = Container();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/img/calendar.png",
                                    height: 20,
                                    width: 20,
                                    color: selectTab == 2
                                        ? TColor.white
                                        : TColor.gray30,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectTab = 3;
                                      currentScreen = Container();
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/img/creditcards.png",
                                    height: 20,
                                    width: 20,
                                    color: selectTab == 3
                                        ? TColor.white
                                        : TColor.gray30,
                                  )),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: TColor.secondary.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset("assets/img/center_btn.png",
                              height: 55, width: 55),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
