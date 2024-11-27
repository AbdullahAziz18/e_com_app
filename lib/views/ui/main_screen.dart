import 'package:e_com_app/controllers/main_screen_provider.dart';
import 'package:e_com_app/views/shared/bottom_navigator.dart';
import 'package:e_com_app/views/ui/cart_page.dart';
import 'package:e_com_app/views/ui/favourite_page.dart';
import 'package:e_com_app/views/ui/home_page.dart';
import 'package:e_com_app/views/ui/profile.dart';
import 'package:e_com_app/views/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Mainscreen extends StatelessWidget {
  Mainscreen({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const FavouritePage(),
    const CartPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProivder>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xffe2e2e2),
          body: pageList[provider.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
