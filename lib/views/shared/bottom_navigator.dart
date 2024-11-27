import 'package:e_com_app/controllers/main_screen_provider.dart';
import 'package:e_com_app/views/shared/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProivder>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavigatorWidget(
                    onTap: () {
                      provider.pageIndex = 0;
                    },
                    icon: provider.pageIndex == 0
                        ? Icons.home
                        : Icons.home_outlined,
                  ),
                  BottomNavigatorWidget(
                    onTap: () {
                      provider.pageIndex = 1;
                    },
                    icon: provider.pageIndex == 1
                        ? Ionicons.search
                        : Ionicons.search_outline,
                  ),
                  BottomNavigatorWidget(
                    onTap: () {
                      provider.pageIndex = 2;
                    },
                    icon: provider.pageIndex == 2
                        ? Ionicons.heart
                        : Ionicons.heart_circle_outline,
                  ),
                  BottomNavigatorWidget(
                    onTap: () {
                      provider.pageIndex = 3;
                    },
                    icon: provider.pageIndex == 3
                        ? Ionicons.cart
                        : Ionicons.cart_outline,
                  ),
                  BottomNavigatorWidget(
                    onTap: () {
                      provider.pageIndex = 4;
                    },
                    icon: provider.pageIndex == 4
                        ? Ionicons.person
                        : Ionicons.person_outline,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
