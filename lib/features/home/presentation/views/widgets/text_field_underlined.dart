import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/textstyle_class.dart';

class TextFieldWithUnderlineBorder extends StatelessWidget {
  const TextFieldWithUnderlineBorder(
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
        filled: true,
        hintStyle: TextStyleClass.greySemiBold14,
        hintText: hintText,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
