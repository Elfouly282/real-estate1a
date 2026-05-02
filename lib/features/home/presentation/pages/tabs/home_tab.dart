import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/appbar/app_bar_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/home_app_bar.dart';
import 'package:real_estate_1a/features/home/presentation/widgets/search_bar.dart';

import '../../../../../core/di.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppBarCubit>(),  // ← أضف
      child: Scaffold(
        appBar: HomeAppBar(),
        body: const Column(
          children: [
            SearchBarWidget(),
          ],
        ),
      ),
    );
  }
}