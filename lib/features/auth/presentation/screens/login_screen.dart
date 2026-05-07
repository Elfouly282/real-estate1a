import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/features/auth/presentation/screens/register_screen.dart';

import '../../../../core/constant/custom_button.dart';
import '../../../../core/constant/custom_textformfield.dart';
import '../../../../core/constant/snakbar.dart';
import '../../../../core/funcations/app_functions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../cubit/auth_cubit.dart';

import '../../../../../core/di.dart';
import '../cubit/auth_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            CustomSnackbar(
              AppColors.primaryColor,
              'Signed in successfully!',
              false,
            ).show(context);
            Future.delayed(const Duration(seconds: 1), () {
             // AppFunctions.navigateToAndFinish(context, const HomeScreen());
            });
          } else if (state is GoogleAuthSuccess) {
            CustomSnackbar(
              AppColors.primaryColor,
              'Signed in with Google successfully!',
              false,
            ).show(context);
            Future.delayed(const Duration(seconds: 1), () {
           //   AppFunctions.navigateToAndFinish(context, const HomeScreen());
            });
          } else if (state is AuthError) {
            CustomSnackbar(AppColors.errorColor, state.message, false).show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.secondaryColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70.h),
                      Center(
                        child: Image.asset(
                          Assets.icon.loggo.path,
                          height: 50,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Sign In Account',
                        style: getMediumStyle(
                          fontSize: 20,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: getRegularStyle(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextformfeild(
                        controller: _emailController,
                        hintText: 'insert your email',
                        keyboardType: TextInputType.emailAddress,
                        formFieldKey: const ValueKey('email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: getRegularStyle(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextformfeild(
                        controller: _passwordController,
                        hintText: 'insert your password',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        formFieldKey: const ValueKey('password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: getRegularStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      state is AuthLoading
                          ? const CircularProgressIndicator(color: AppColors.primaryColor,)
                          : CustomButton(
                        data: 'Login',
                        fontSize: 12,
                        height: 38,
                        borderRadius: 6.9,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              email: _emailController.text.trim(),
                              password:
                              _passwordController.text.trim(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              'or login with',
                              style: getRegularStyle(
                                fontSize: 13,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        height: 43.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greychip,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icon.googleicon.image(height: 20),
                              SizedBox(width: 13.w),
                              Text(
                                'Continue with Google',
                                style: getMediumStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 43.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icon.appleicon.image(height: 20),
                              SizedBox(width: 13.w),
                              Text(
                                'Continue with Apple',
                                style: getMediumStyle(
                                    fontSize: 12, color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: getRegularStyle(
                                fontSize: 12, color: AppColors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              AppFunctions.navigateToAndReplacement(
                                  context, const RegisterScreen());

                            },
                            child: Text(
                              'Sign Up',
                              style: getMediumStyle(
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: getRegularStyle(
                              fontSize: 12, color: AppColors.black),
                          children: [
                            const TextSpan(
                                text: 'By signing in, you agree to our '),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: getMediumStyle(
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const TextSpan(
                                text: '. Learn how we use your data '),
                            TextSpan(
                              text: 'in our Privacy Policy',
                              style: getMediumStyle(
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}