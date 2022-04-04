import 'package:flutter/material.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';

Widget vSpace(double space) {
  return SizedBox(
    height: space,
  );
}

Widget hSpace(double space) {
  return SizedBox(
    width: space,
  );
}

Widget homeAppBar(
    BuildContext context, Text title, String imageAsset, String iconAsset,
    {bool isCenterAligned = false}) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              imageAsset,
              height: 54,
              width: 54,
            ),
            hSpace(12),
            title,
          ],
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: blue20,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              iconAsset,
              height: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
