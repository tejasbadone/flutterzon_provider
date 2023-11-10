import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../screens/add_product_screen.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AddProductScreen.routeName);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: GlobalVariables.selectedNavBarColor,
      tooltip: 'Add a product',
      child: const Icon(Icons.add),
    );
  }
}
