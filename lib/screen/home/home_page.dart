import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/screen/account/account_page.dart';
import 'package:my_e_com/screen/auth/sign_up_page.dart';
import 'package:my_e_com/screen/cart/cart_history.dart';
import 'package:my_e_com/screen/cart/cart_page.dart';
import 'package:my_e_com/screen/home/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  List page = [
    const MainFoodPage(),//todo
    const CartPage(),
    const CartHistory(),
    const AccountPage()
  ];

  List<BottomNavigationBarItem> item = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined), label: "History"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person_outlined), label: "Profile"),
  ];

  void onTapNav(int index) {
    print("tap tap $index");
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: onTapNav,
          currentIndex: _selectedPage,
          items: item),
    );
  }
}
