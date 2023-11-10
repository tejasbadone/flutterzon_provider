import 'package:flutter/material.dart';

import '../screens/order_details.dart';

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.textSyle,
    required this.widget,
  });

  final TextStyle textSyle;
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
          style: textSyle.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          secondText,
          style: textSyle.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
