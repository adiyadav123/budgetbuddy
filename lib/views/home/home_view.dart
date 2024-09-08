import 'package:budgetbuddy/common/color_extension.dart';
import 'package:budgetbuddy/common_widget/segment_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscribed = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: media.width * 1.1,
              decoration: BoxDecoration(
                color: TColor.gray70,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: 60,
            decoration: BoxDecoration(
                color: TColor.gray, borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                Expanded(
                  child: SegmentButton(
                      title: "Your subscriptions",
                      isActive: isSubscribed,
                      onTap: () {
                        setState(() {
                          isSubscribed = !isSubscribed;
                        });
                      }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SegmentButton(
                      title: "Upcoming Bills",
                      isActive: !isSubscribed,
                      onTap: () {
                        setState(() {
                          isSubscribed = !isSubscribed;
                        });
                      }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
