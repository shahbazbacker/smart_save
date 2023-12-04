import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/textstyle_class.dart';

class TextFieldBordered extends StatelessWidget {
  const TextFieldBordered(
      {super.key,
      required this.controller,
      required this.hintText,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next});

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.greenAccent, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black600, width: 1.0),
          ),
          filled: true,
          hintStyle: TextStyleClass.greySemiBold14,
          hintText: hintText,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0)),
    );
  }
}
