import 'package:flutter/material.dart';

class SocialAuthIconWidget extends StatelessWidget {
  const SocialAuthIconWidget(
      {super.key, required this.icon, this.color, this.onTap});

  final String icon;
  final Color? color;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 8,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Image.asset(
          icon,
          width: 30.0,
          height: 30.0,
          color: color,
        ),
      ),
    );
  }
}
