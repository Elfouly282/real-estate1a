import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/home/home_cubit.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value) =>
                  context.read<HomeCubit>().searchProperties(value),
              decoration: InputDecoration(
                hintText: 'Search your home',
                prefixIcon: const Icon(
                    Icons.search, color: Colors.grey, size: 24),
                // ── clear button ──────────────────────────────────
                suffixIcon: _controller.text.isNotEmpty
                    ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                    context.read<HomeCubit>().clearSearch();
                  },
                  child: const Icon(
                      Icons.close, color: Colors.grey, size: 18),
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 42.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Icon(
                  Icons.tune_rounded, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}