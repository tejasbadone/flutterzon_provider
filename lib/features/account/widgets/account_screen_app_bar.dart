import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AccuntScreenAppBar extends StatelessWidget {
  const AccuntScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
