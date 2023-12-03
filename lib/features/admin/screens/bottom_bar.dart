import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/screens/home_screen_admin.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variables.dart';
import 'analytics_screen.dart';
import 'orders_screen.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 38;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreenAdmin(),
    const AnalyticsScreen(),
    const OrdersScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: 120,
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/amazon_black_logo.png'),
              ),
              Row(
                children: [
                  const Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                      onPressed: () async {
                        try {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();

                          await sharedPreferences.setString('x-auth-token', '');

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const AuthScreen())),
                                (route) => false);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, e.toString());
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.power_settings_new,
                        size: 25,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          currentIndex: _page,
          selectedLabelStyle: TextStyle(
              color: GlobalVariables.selectedNavBarColor, fontSize: 13),
          unselectedLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 13),
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          enableFeedback: false,
          iconSize: 28,
          elevation: 0,
          onTap: updatePage,
          items: [
            bottomNavBarItem(
                icon: const Icon(Icons.home_outlined), page: 0, label: 'Home'),
            bottomNavBarItem(
                icon: const Icon(Icons.analytics_outlined),
                page: 1,
                label: 'Analytics'),
            bottomNavBarItem(
                icon: const Icon(Icons.local_shipping_outlined),
                page: 2,
                label: 'Orders'),
          ],
        ),
      ),
      body: pages[_page],
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
      {required Widget icon, required int page, required String label}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
            width: bottomBarWidth,
            height: 6,
            decoration: BoxDecoration(
              color: _page == page
                  ? GlobalVariables.selectedNavBarColor
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          icon
        ],
      ),
      label: label,
    );
  }
}
