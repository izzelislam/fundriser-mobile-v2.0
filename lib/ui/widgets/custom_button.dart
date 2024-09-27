import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool isOutline;
  final bool? isLoading;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isOutline = false,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading! ? null : onPressed,
      style: TextButton.styleFrom(
        disabledBackgroundColor: blueColor.withOpacity(0.6),
        backgroundColor: isOutline ? whiteColor : blueColor,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isOutline ? BorderSide(color: blueColor) : BorderSide.none
        )
      ), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading! ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,)) : const SizedBox(width: 16, height: 16,),
          isLoading! ? const SizedBox(width: 12,) : const SizedBox(width: 0,),
          Text(title, style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isOutline ? blueColor : whiteColor
          ),),
        ],
      ),
    );
  }
}