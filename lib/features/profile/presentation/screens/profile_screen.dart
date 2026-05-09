import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/features/profile/data/profile_repo_impl.dart';
import 'package:real_estate_1a/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:real_estate_1a/features/profile/presentation/widgets/profile_header_widget.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/di.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_menu_item_widget.dart';
import 'change_password_screen.dart';
import 'my_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProfileCubit>()..getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            _cubit.getProfile();
          },
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailure) {
                CustomSnackbar(
                  AppColors.errorColor,
                  state.message,
                  true,
                ).show(context);
              }
            },
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              if (state is ProfileSuccess) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ProfileHeaderWidget(user: state.user),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user.name,
                            style: getBoldStyle(
                              fontSize: 24,
                              color: AppColors.darkColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (state.user.location != null)
                            Text(
                              state.user.location!,
                              style: getLightStyle(
                                fontSize: 16,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                          const SizedBox(height: 24),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.darkColor.withValues(
                                    alpha: 0.06,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Setting',
                                  style: getLightStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ProfileMenuItemWidget(
                                  image: Assets.icon.personalicon.path,
                                  title: 'Personal Information',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PersonalInformationScreen(
                                              user: state.user,
                                            ),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 18),
                                ProfileMenuItemWidget(
                                  image: Assets.icon.editaccount.path,
                                  title: 'My Account',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            MyAccountScreen(user: state.user),
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(height: 16.h),

                                // const Divider(height: 1,color: AppColors.grey,),
                                // const SizedBox(height: 24,),
                                // Text('Payment',
                                //   style: getLightStyle(
                                //     fontSize: 13,
                                //     color: AppColors.textSecondaryColor,
                                //   ),),
                                //const SizedBox(height: 30,),
                                // ProfileMenuItemWidget(
                                //   image: Assets.icon.paymenticon.path,
                                //   title: 'Payment Method',
                                //   onTap: () {},
                                // ),
                                const SizedBox(height: 16),

                                const Divider(height: 1, color: AppColors.grey),
                                const SizedBox(height: 24),
                                Text(
                                  'Setting & Security',
                                  style: getLightStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ProfileMenuItemWidget(
                                  image: Assets.icon.passwordicon.path,
                                  title: 'Change Password',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const ChangePasswordScreen(),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 18),
                                ProfileMenuItemWidget(
                                  image: Assets.icon.notificationicon.path,
                                  title: 'Notification Preference',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
