import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../configs/colors.dart';
import '../configs/textstyle_class.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom(
      {super.key,
      this.onTap,
      required this.label,
      this.isLoading = false,
      this.padding,
      this.borderRadius,
      this.icon});

  final Function? onTap;
  final String label;
  final bool isLoading;
  final String? icon;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                  (Set<MaterialState> states) {
                    return EdgeInsets.all(padding ?? 15.0);
                  },
                ),
                maximumSize: MaterialStateProperty.all(Size(size.width, 60)),
                shadowColor: MaterialStateProperty.all(
                    AppColors.primaryColor.withOpacity(0.5)),
                elevation: MaterialStateProperty.all(4.0),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                ))),
            onPressed: () {
              if (onTap != null) {
                onTap!();
              }
            },
            icon: icon != null
                ? Image.asset(
                    icon!,
                    color: AppColors.white,
                    height: 18,
                  )
                : const SizedBox(),
            label: isLoading
                ? const SpinKitWave(
                    color: Colors.white,
                    size: 25.0,
                  )
                : Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleClass.whiteSemiBold14,
                  ),
          ),
        ),
      ],
    );
  }
}
