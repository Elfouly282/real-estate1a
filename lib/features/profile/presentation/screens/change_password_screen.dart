import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/custom_button.dart';
import '../../../../core/constant/custom_textformfield.dart';
import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_outlined,size: 16,),
          ),
          title: Text(
            'Change Password',
            style: getRegularStyle(
              fontSize: 16,
              color: AppColors.darkColor,
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              CustomSnackbar(
                AppColors.errorColor,
                state.message,
                true,
              ).show(context);
            }
            if (state is ChangePasswordSuccess) {
              CustomSnackbar(
                AppColors.successColor,
                'Password changed successfully',
                false,
              ).show(context);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(

                  children: [

                    CustomTextformfeild(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _currentPasswordController,
                      labelText: 'Current Password',
                      hintText: 'Enter current password',
                      isPassword: true,
                      formFieldKey: const Key('current_password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfeild(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _newPasswordController,
                      labelText: 'New Password',
                      hintText: 'Enter new password',
                      isPassword: true,
                      formFieldKey: const Key('new_password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfeild(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm new password',
                      isPassword: true,
                      formFieldKey: const Key('confirm_password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      height: 40,
                      fontSize: 13,
                      data: 'Change Password',
                      isLoading: state is ProfileLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileCubit>().changePassword(
                            currentPassword: _currentPasswordController.text,
                            password: _newPasswordController.text,
                            passwordConfirmation: _confirmPasswordController.text,
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