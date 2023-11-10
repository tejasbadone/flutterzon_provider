import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/features/account/screens/account_screen.dart';
import 'package:amazon_clone_flutter/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/features/menu/screens/menu_screen.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/more/screens/more_screen.dart';
import '../../providers/screen_number_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottomBar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  bool isItOpen = false;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const MoreScreen(),
    const CartScreen(),
    const MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    final screenNumberProvider =
        Provider.of<ScreenNumberProvider>(context, listen: false);
    final isOpen = Provider.of<ScreenNumberProvider>(context, listen: false);

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: SafeArea(
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _page,
            showSelectedLabels:
                _page == 2 && isOpen.isOpen == true ? false : true,
            showUnselectedLabels: true,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            selectedLabelStyle: TextStyle(
                color: _page != 2
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.unselectedNavBarColor,
                fontSize: 13),
            unselectedLabelStyle: const TextStyle(
                color: GlobalVariables.unselectedNavBarColor, fontSize: 13),
            selectedItemColor: _page != 2
                ? GlobalVariables.selectedNavBarColor
                : GlobalVariables.unselectedNavBarColor,
            unselectedItemColor: GlobalVariables.unselectedNavBarColor,
            backgroundColor: GlobalVariables.backgroundColor,
            enableFeedback: false,
            iconSize: 28,
            elevation: 0,
            onTap: (page) {
              if (page != 2) {
                screenNumberProvider.setScreenNumber(page);
              }

              if (page == 2 && isOpen.isOpen == false) {
                isItOpen = true;
                isOpen.setIsOpen(isItOpen);
              } else {
                isItOpen = false;
                isOpen.setIsOpen(isItOpen);
              }

              if (page == 2 && isOpen.isOpen == false && _page == 2) {
                setState(() {
                  _page = isOpen.screenNumber;
                });
              } else {
                setState(() {
                  _page = page;
                });
              }
            },
            items: [
              bottomNavBarItem(
                icon: bottomBarImage(iconName: 'home', page: 0),
                page: 0,
                label: 'Home',
              ),
              bottomNavBarItem(
                icon: bottomBarImage(iconName: 'you', page: 1),
                page: 1,
                label: 'You',
              ),
              bottomNavBarItem(
                icon: bottomBarImage(iconName: 'more', page: 2),
                page: 2,
                label: 'More',
              ),
              bottomNavBarItem(
                icon: Stack(
                  children: [
                    bottomBarImage(
                        iconName: 'cart', page: 3, width: 25, height: 25),
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Text(
                        userCartLength.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _page == 3
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.unselectedNavBarColor),
                      ),
                    ),
                  ],
                ),
                page: 3,
                label: 'Cart',
              ),
              bottomNavBarItem(
                icon: bottomBarImage(iconName: 'menu', page: 4),
                page: 4,
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem({
    required Widget icon,
    required int page,
    required String label,
  }) {
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Container(
              width: bottomBarWidth,
              height: 5.5,
              decoration: BoxDecoration(
                color: _page == page && _page != 2
                    ? GlobalVariables.selectedNavBarColor
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            icon,
            const SizedBox(
              height: 6,
            ),
          ],
        ),
        label: label);
  }

  Image bottomBarImage(
      {required String iconName,
      required int page,
      double height = 20,
      double width = 20}) {
    final screenNumberProvider =
        Provider.of<ScreenNumberProvider>(context, listen: false);

    return Image.asset('assets/images/bottom_nav_bar/$iconName.png',
        height: height,
        width: width,
        color:
            _page == 2 && screenNumberProvider.isOpen == true && _page == page
                ? GlobalVariables.selectedNavBarColor
                : _page != 2 &&
                        screenNumberProvider.isOpen == false &&
                        _page == page
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.unselectedNavBarColor);
  }
}
