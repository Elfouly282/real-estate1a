import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/features/favourite/pressentation/pages/favorites_tab.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/pages/tabs/home_tab.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/home_app_bar.dart';
import '../../../../../core/di/di.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _pages = [
    const HomeTab(),
    FavoritesTab(),
    const _PlaceholderPage(label: 'Map',      color: Color(0xFFE6F1FB)),
    const _PlaceholderPage(label: 'History',  color: Color(0xFFFAEEDA)),
    const _PlaceholderPage(label: 'Profile',  color: Color(0xFFEEEDFE)),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppBarCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _currentIndex == 2 ? null : const HomeAppBar() ,
        body: _pages[_currentIndex],
        bottomNavigationBar: AppNavBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
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