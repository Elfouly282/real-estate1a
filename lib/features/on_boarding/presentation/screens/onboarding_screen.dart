import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../widgets/on_boarding_item.dart';
import '../../../../core/funcations/app_functions.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingEntity> _pages = [
    const OnboardingEntity(
      image: 'assets/images/onboarding1.png',
      title: 'Find Your Perfect Home, Anywhere',
      subTitle: 'Start your journey with a comfortable and reliable home search',
    ),
    const OnboardingEntity(
      image: 'assets/images/onboarding2.jpeg',
      title: 'Explore Top Locations',
      subTitle: 'Discover the best properties in your area',
    ),
    const OnboardingEntity(
      image: 'assets/images/onboarding3.jpeg',
      title: 'Easy & Fast Booking',
      subTitle: 'Book your dream home in just a few taps',
    ),
  ];

  void _navigateToLogin() {
    AppFunctions.navigateToAndFinish(context, const LoginScreen());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingItem(entity: _pages[index]);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    _pages.length,
                        (index) => Container(
                      margin: EdgeInsets.only(right: 6.w),
                      width: 34.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    if (_currentPage > 0) ...[
                      GestureDetector(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          width: 48.w,
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: AppColors.white,
                            size: 17.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],

                    GestureDetector(
                      onTap: () {
                        if (_currentPage < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _navigateToLogin();
                        }
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.white,
                          size: 17.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 40.h),
            child: CustomButton(
              height: 44,
              fontSize: 15.sp,
              data: _currentPage < _pages.length - 1 ? 'Continue' : 'Get Started',
              onTap: () {
                if (_currentPage < _pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  _navigateToLogin();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}