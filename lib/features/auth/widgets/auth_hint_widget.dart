import 'package:flutter/material.dart';
import 'package:practical_google_maps_example/core/styling/app_colors.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';

class AuthHintWidget extends StatelessWidget {
  const AuthHintWidget({
    super.key,
    required this.hintText,
    required this.buttonText,
    this.onTap,
  });
  final String hintText;
  final String buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: hintText,
            style: AppStyles.black16w500Style
                .copyWith(color: AppColors.secondaryColor),
            children: [
              TextSpan(text: buttonText, style: AppStyles.black15BoldStyle)
            ],
          ),
        ),
      ),
    );
  }
}
