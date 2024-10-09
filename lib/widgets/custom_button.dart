import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isWhiteColor;
  final double width;
  final VoidCallback? onTap;
  const CustomButton(
      {super.key,
      required this.title,
      required this.isWhiteColor,
      required this.width,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 60,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isWhiteColor ? Colors.white : const Color(0XFF3D5CFF),
          border: isWhiteColor
              ? Border.all(
                  color: const Color(
                    0xFF3D5CFF,
                  ),
                )
              : Border.all(color: Colors.white),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isWhiteColor
                ? const Color(
                    0xFF3D5CFF,
                  )
                : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
