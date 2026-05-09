import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 1,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Color(0XFF1597A8)),

    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 20,
          color: Color(0XFF1597A8)
        ),
        const SizedBox(width: 6),

        Column( 
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Discover Properties",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Nearby you",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}