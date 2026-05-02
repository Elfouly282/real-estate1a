import 'package:flutter/material.dart';
import 'package:real_estate_1a/core/constant/custom_app_bar.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/features/home/presentation/pages/tabs/home_tab.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomeTab(),
    _PlaceholderPage(label: 'Favorite', color: Color(0xFFFCEBEB)),
    _PlaceholderPage(label: 'Map',      color: Color(0xFFE6F1FB)),
    _PlaceholderPage(label: 'History',  color: Color(0xFFFAEEDA)),
    _PlaceholderPage(label: 'Profile',  color: Color(0xFFEEEDFE)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
          body: _pages[_currentIndex],
          bottomNavigationBar: AppNavBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),)
        );

  }

}
class _PlaceholderPage extends StatelessWidget {
  final String label;
  final Color color;

  const _PlaceholderPage({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}

