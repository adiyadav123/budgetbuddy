import 'package:budgetbuddy/common/color_extension.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final String asset;
  final String icon;
  final Color textColor;
  final Color iconColor;
  final Color shadowColor;

  const LoginButton(
      {super.key,
      required this.asset,
      required this.title,
      required this.icon,
      required this.textColor,
      required this.iconColor,
      required this.shadowColor,
      required this.onPressed});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
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
            boxShadow: [
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.icon,
                color: widget.iconColor,
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: widget.textColor,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
