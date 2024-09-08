import 'package:budgetbuddy/common/color_extension.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final String asset;

  const SecondaryButton(
      {super.key,
      required this.fontSize,
      required this.fontWeight,
      required this.asset,
      required this.title,
      required this.onPressed});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  double _scale = 1.0;

  void zoomOut() {
    setState(() {
      _scale = 1.0;
    });
  }

  void zoomIn() {
    setState(() {
      _scale = 0.8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => zoomIn(),
      onTapUp: (details) => zoomOut(),
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.asset),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(
                fontFamily: "Inter",
                fontWeight: widget.fontWeight,
                color: TColor.white,
                fontSize: widget.fontSize),
          ),
        ),
      ),
    );
  }
}
