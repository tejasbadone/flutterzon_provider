import 'package:amazon_clone_flutter/features/account/screens/account_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/screen_number_provider.dart';
import '../../cart/screens/cart_screen.dart';
import '../widgets/custom_bottom_sheet.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({
    super.key,
  });

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final screenNumberProvider =
        Provider.of<ScreenNumberProvider>(context, listen: false);

    Widget getScreen({
      required int screenNumber,
    }) {
      if (screenNumber == 0) {
        return const HomeScreen();
      } else if (screenNumber == 1) {
        return const AccountScreen();
      } else if (screenNumber == 3) {
        return const CartScreen();
      } else if (screenNumber == 4) {
        return const Scaffold(
          body: Center(
            child: Text('Menu Screen'),
          ),
        );
      }
      return const HomeScreen();
    }

    return Scaffold(body:
            Consumer<ScreenNumberProvider>(builder: (context, provider, child) {
      final isOpen = provider.isOpen;
      return isOpen == true
          ? Stack(
              children: [
                getScreen(screenNumber: screenNumberProvider.screenNumber),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            )
          : getScreen(screenNumber: screenNumberProvider.screenNumber);
    }),
        // : getScreen(screenNumber: screenNumberProvider),
        bottomSheet: Consumer<ScreenNumberProvider>(
            builder: ((context, provider, child) {
      final isOpen = provider.isOpen;

      return isOpen == true
          ? BottomSheet(
              backgroundColor: const Color(0xffffffff),
              shadowColor: Colors.white,
              dragHandleColor: const Color(0xffDDDDDD),
              dragHandleSize: const Size(50, 4),
              enableDrag: false,
              showDragHandle: true,
              constraints: const BoxConstraints(minHeight: 400, maxHeight: 400),
              onClosing: () {},
              builder: (context) {
                return const CustomBottomSheet();
              },
            )
          : const SizedBox();
    })));
  }
}
