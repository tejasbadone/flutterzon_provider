import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../screens/order_details.dart';

class OrderSummaryTotal extends StatelessWidget {
  const OrderSummaryTotal({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.headingTextSyle,
    required this.widget,
  });

  final TextStyle headingTextSyle;
  final String firstText;
  final String secondText;
  final OrderDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: headingTextSyle,
        ),
        Text(
          secondText,
          style: headingTextSyle.copyWith(
            color: GlobalVariables.redColor,
          ),
        )
      ],
    );
  }
}
