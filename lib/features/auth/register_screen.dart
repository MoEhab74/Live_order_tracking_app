import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/styling/app_assets.dart';
import 'package:practical_google_maps_example/core/styling/app_colors.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/utils/animated_snack_dialog.dart';
import 'package:practical_google_maps_example/core/widgets/custom_text_field.dart';
import 'package:practical_google_maps_example/core/widgets/primay_button_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_google_maps_example/features/auth/cubit/auth_cubit.dart';
import 'package:practical_google_maps_example/features/auth/cubit/auth_state.dart';
import 'package:practical_google_maps_example/features/auth/widgets/auth_header_widget.dart';
import 'package:practical_google_maps_example/features/auth/widgets/auth_hint_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              showAnimatedSnackDialog(
                context,
                message: state.message,
                type: AnimatedSnackBarType.success,
              );
              GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
              username.clear();
              email.clear();
              password.clear();
              confirmPassword.clear();
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
            } else if (state is AuthError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpace(28),
                      const AuthHeader(
                        title: "Create an account",
                        subTitle: "Let’s create your account.",
                        image: AppAssets.order,
                      ),
                      const HeightSpace(32),
                      Text("User Name", style: AppStyles.black16w500Style),
                      const HeightSpace(8),
                      // Start of the form fields
                      CustomTextField(
                        controller: username,
                        hintText: "Enter Your User Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your User Name";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text("Email", style: AppStyles.black16w500Style),
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
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text("Confirm Password",
                          style: AppStyles.black16w500Style),
                      const HeightSpace(8),
                      CustomTextField(
                        hintText: "Enter Your Password",
                        controller: confirmPassword,
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: AppColors.greyColor,
                          size: 20.sp,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          if (value != password.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(55),
                      PrimayButtonWidget(
                        buttonText: "Create Account",
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).registerUser(
                                username.text, email.text, password.text);
                          }
                        },
                      ),
                      const HeightSpace(8),
                      AuthHintWidget(
                        hintText: "Already have an account? ",
                        buttonText: "Login",
                        onTap: () => GoRouter.of(context).pop(),
                      ),
                      const HeightSpace(16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
