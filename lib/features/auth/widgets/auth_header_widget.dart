import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image});
  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 335.w,
          child: Text(
            title,
            style: AppStyles.primaryHeadLinesStyle,
          ),
        ),
        const HeightSpace(8),
        SizedBox(
          width: 335.w,
          child: Text(
            subTitle,
            style: AppStyles.grey12MediumStyle,
          ),
        ),
        const HeightSpace(20),
        Center(
          child: Image.asset(
            image,
            width: 190.w,
            height: 190.w,
          ),
        ),
      ],
    );
  }
}
