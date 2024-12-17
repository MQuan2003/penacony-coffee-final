import 'package:flutter/material.dart';
import 'package:p_cf/view/page/gift/gift_home.dart';
import 'package:p_cf/view/page/homepage.dart';
import 'package:p_cf/view/page/menu/menu.dart';
import 'package:p_cf/view/page/promotion/promotion_screen.dart';

import 'package:p_cf/view/page/account/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void _navigateToPage(int index, BuildContext context) {
    final pages = [
      const HomeScreen(),
      const MenuScreen(),
      const PromotionScreen(),
      const GiftPage(),
      const ProfileScreen(),
    ];
    if (index != currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => pages[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex, // Tab đang được chọn
      onTap: (index) {
        _navigateToPage(index, context);
      },
      selectedItemColor: const Color(0xFF129575), // Màu tab được chọn
      unselectedItemColor: Colors.grey, // Màu tab không được chọn
      selectedFontSize: 14,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Khuyến mãi'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Quà tặng'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Tài khoản'),
      ],
    );
  }
}
