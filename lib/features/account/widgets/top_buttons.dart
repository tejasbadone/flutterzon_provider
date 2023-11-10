import 'package:amazon_clone_flutter/features/account/screens/wish_list_screen.dart';
import 'package:amazon_clone_flutter/features/account/services/account_services.dart';
import 'package:amazon_clone_flutter/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

import '../screens/your_orders.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(
                buttonName: 'Your Orders',
                onPressed: () =>
                    Navigator.pushNamed(context, YourOrders.routeName)),
            const SizedBox(
              width: 10,
            ),
            AccountButton(buttonName: 'Buy Again', onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountButton(
                buttonName: 'Log Out',
                onPressed: () => AccountServices().logOut(context)),
            const SizedBox(
              width: 10,
            ),
            AccountButton(
                buttonName: 'Wish List',
                onPressed: () {
                  Navigator.pushNamed(context, WishListScreen.routeName);
                }),
          ],
        ),
      ],
    );
  }
}
