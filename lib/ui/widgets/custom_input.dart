import 'package:flutter/material.dart';
import 'package:fundriser/shared/theme.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final bool isLabel;

  const CustomInput({
    super.key,
    this.label,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.hintText,
    this.onFieldSubmitted,
    this.isLabel = true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShowTitle ? Text(label?? '', style: darkGrayTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w600)) : const SizedBox(),
        // Text(label?? '', style: grayTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2,),
        TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          onSubmitted: onFieldSubmitted,
          cursorColor: blueColor,
          style: TextStyle(
            color: darkGrayColor,
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: thinGrayTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            isDense: true,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: thinGrayColor)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: blueColor)
            ),
          ),
        ),
        const SizedBox(height: 19,),
      ],
    );
  }
}