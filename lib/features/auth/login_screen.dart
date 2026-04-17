import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/styling/app_assets.dart';
import 'package:practical_google_maps_example/core/styling/app_colors.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/widgets/custom_text_field.dart';
import 'package:practical_google_maps_example/core/widgets/primay_button_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';
import 'package:practical_google_maps_example/features/auth/widgets/auth_header_widget.dart';
import 'package:practical_google_maps_example/features/auth/widgets/auth_hint_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightSpace(28),
              const AuthHeader(
                title: "Login To Your Account",
                subTitle: "it's great to see you again",
                image: AppAssets.order,
              ),
              const HeightSpace(32),
              Text("Email", style: AppStyles.black16w500Style),
              const HeightSpace(8),
              CustomTextField(
                controller: email,
                hintText: "Enter Your Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Your Email";
                  }
                  return null;
                },
              ),
              const HeightSpace(16),
              Text("Password", style: AppStyles.black16w500Style),
              const HeightSpace(8),
              CustomTextField(
                hintText: "Enter Your Password",
                controller: password,
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: AppColors.greyColor,
                  size: 20.sp,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Your Password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const HeightSpace(55),
              PrimayButtonWidget(
                buttonText: "Sign in",
                onPress: () {
                  //    if (formKey.currentState!.validate()) {
                  //   GoRouter.of(context).pushNamed(AppRoutes.verifyOtpScreen);
                  //  }
                },
              ),
              const Spacer(),
              AuthHintWidget(
                hintText: "Don't have an account? ",
                buttonText: "Sign up",
                onTap: () => GoRouter.of(context).pushNamed(AppRoutes.registerScreen),
              ),
              const HeightSpace(16),
            ],
          ),
        ),
      ),
    ));
  }
}

