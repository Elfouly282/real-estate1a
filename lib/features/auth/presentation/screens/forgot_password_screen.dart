import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/custom_button.dart';
import '../../../../core/constant/custom_textformfield.dart';
import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_outlined,size: 17,),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              CustomSnackbar(
                AppColors.errorColor,
                state.message,
                true,
              ).show(context);
            }
            if (state is ForgotPasswordSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(email: _emailController.text),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password',
                      style: getMediumStyle(
                        fontSize: 22,
                        color: AppColors.darkColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enter your email address and we will send you a reset token',
                      style: getLightStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextformfeild(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      formFieldKey: const Key('email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      height: 40,
                      fontSize: 14,
                      data: 'Send',
                      isLoading: state is AuthLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().forgotPassword(
                            email: _emailController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}