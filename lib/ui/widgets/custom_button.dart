import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool isOutline;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isOutline = false
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isOutline ? whiteColor : blueColor,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isOutline ? BorderSide(color: blueColor) : BorderSide.none
        )
      ), 
      child: Text(title, style: whiteTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isOutline ? blueColor : whiteColor
      ),),
    );
  }
}