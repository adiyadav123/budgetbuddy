import 'package:budgetbuddy/common/color_extension.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const PrimaryButton(
      {super.key,
      required this.fontSize,
      required this.fontWeight,
      required this.title,
      required this.onPressed});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
        duration:const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/img/primary_btn.png"),
            ),
            boxShadow: [
              BoxShadow(
                color: TColor.secondary.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
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
