import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/gen/assets.gen.dart';

import '../../../../core/constant/custom_button.dart';
import '../../../../core/constant/custom_textformfield.dart';
import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class MyAccountScreen extends StatefulWidget {
  final UserEntity user;

  const MyAccountScreen({
    super.key,
    required this.user,
  });

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _locationController = TextEditingController(text: widget.user.location ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
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
            'My Account',
            style: getLightStyle(
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
            if (state is ProfileUpdateSuccess) {
              CustomSnackbar(
                AppColors.successColor,
                'Profile updated successfully',
                false,
              ).show(context);
              Navigator.pop(context);
            }
            if (state is DeleteAccountSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextformfeild(
                      prefixIcon: Icon(Icons.person_4,size: 20,color: AppColors.primaryColor,),
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      formFieldKey: const Key('name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfeild(
                      prefixIcon: Icon(Icons.phone_in_talk_sharp,size: 20,color: AppColors.primaryColor,),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      labelText: 'Phone',
                      hintText: 'Enter your phone',
                      formFieldKey: const Key('phone'),
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfeild(
                      prefixIcon: Icon(Icons.location_on,size: 20,color: AppColors.primaryColor,),
                      keyboardType: TextInputType.text,
                      controller: _locationController,
                      labelText: 'Location',
                      hintText: 'Enter your location',
                      formFieldKey: const Key('location'),
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 35),
                    CustomButton(
                      height: 40,
                      data: 'Save Changes',
                      fontSize: 13,
                      isLoading: state is ProfileLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileCubit>().updateProfile(
                            name: _nameController.text,
                            phone: _phoneController.text.isEmpty
                                ? null
                                : _phoneController.text,
                            location: _locationController.text.isEmpty
                                ? null
                                : _locationController.text,
                          );
                        }
                      },
                    ),

                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'or delete your account',
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
                    SizedBox(height: 20.h),
                    CustomButton(
                      height: 40,
                      fontSize: 13,
                      data: 'Delete Account',
                      color: AppColors.errorColor,
                      bordercolor: AppColors.errorColor,
                      onTap: () {
                        _showDeleteDialog(context);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Delete Account',
          style: getBoldStyle(
            fontSize: 16,
            color: AppColors.darkColor,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: getLightStyle(
            fontSize: 14,
            color: AppColors.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: getMediumStyle(
                fontSize: 14,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().deleteAccount();
            },
            child: Text(
              'Delete',
              style: getMediumStyle(
                fontSize: 14,
                color: AppColors.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}