import 'package:app_pet_care/src/widget/home/home_dortor.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
     backgroundColor: const Color(0XFF0072AD),
        animationDuration: const Duration(milliseconds: 300),
        color: const Color(0xFFFFE3D8),
      items: [
        GestureDetector(
          onTap: () {
            Get.to(HomeDoctor());
          },
          child: const Icon(
            Icons.home,
            size: 32,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.receipt_sharp,
            size: 32,
          ),
        ),
        GestureDetector(
          child: const Icon(
            Icons.search_sharp,
            size: 32,
          ),
          onTap: () {},
        ),
        const Icon(
          Icons.live_tv_outlined,
          size: 32,
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.account_circle_outlined,
            size: 32,
          ),
        ),
      ],
      index: 1,
    );
  }
}