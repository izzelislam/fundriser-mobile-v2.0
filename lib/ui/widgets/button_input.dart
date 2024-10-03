import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class ButtonInput extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool isOutline;
  final bool? isLoading;
  final String? value;

  const ButtonInput({
    super.key,
    this.onPressed,
    required this.title,
    this.isOutline = false,
    this.isLoading = false,
    this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: darkGrayTextStyle.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600
        )),
        const SizedBox(height: 5),
        TextButton(
          onPressed: isLoading! ? null : onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: blueColor.withOpacity(0.6),
            backgroundColor: isOutline ? whiteColor : blueColor,
            minimumSize: const Size.fromHeight(45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: isOutline ? BorderSide(color: thinGrayColor) : BorderSide.none
            )
          ), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isLoading! ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,)) : const SizedBox(width: 16, height: 16,),
              isLoading! ? const SizedBox(width: 12,) : const SizedBox(width: 0,),
              Text(value ?? '', style: whiteTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: grayColor
              ),),
            ],
          ),
        ),
      ],
    );
  }
}