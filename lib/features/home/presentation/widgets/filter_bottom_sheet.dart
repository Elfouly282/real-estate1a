import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';

import '../cubit/home/home_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedType = "All";
  double maxPrice = 500000;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6, // 👈 height added
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const Text(
                "Filter Properties",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedType,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "All", child: Text("All")),
                  DropdownMenuItem(value: "Apartment", child: Text("Apartment")),
                  DropdownMenuItem(value: "Villa", child: Text("Villa")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              Text("Max Price: ${maxPrice.toInt()}"),

              Slider(
                value: maxPrice,
                activeColor: AppColors.primaryColor,
                min: 1000,
                max: 10000000,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    maxPrice = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().clearFilter();
                        Navigator.pop(context);

                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        WidgetStateProperty.all(AppColors.babyBlue),
                      ),
                      onPressed: () {

                        context.read<HomeCubit>().applyFilter(
                          type: selectedType,
                          maxPrice: maxPrice,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}