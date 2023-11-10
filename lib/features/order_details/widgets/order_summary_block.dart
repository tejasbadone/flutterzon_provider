import 'package:flutter/material.dart';

import '../../../constants/utils.dart';
import '../screens/order_details.dart';
import 'order_summary_row.dart';
import 'order_summary_total.dart.dart';

class OrderSummaryBlock extends StatelessWidget {
  const OrderSummaryBlock({
    super.key,
    required this.headingTextSyle,
    required this.containerDecoration,
    required this.totalQuantity,
    required this.textSyle,
    required this.widget,
  });

  final TextStyle headingTextSyle;
  final BoxDecoration containerDecoration;
  final int totalQuantity;
  final TextStyle textSyle;
  final OrderDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Summary', style: headingTextSyle),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: containerDecoration,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            OrderSummaryRow(
                firstText: 'Items:',
                secondText: totalQuantity.toString(),
                textSyle: textSyle,
                widget: widget),
            OrderSummaryRow(
                firstText: 'Postage & Packing:',
                secondText: '₹0',
                textSyle: textSyle,
                widget: widget),
            OrderSummaryRow(
                firstText: 'Sub total:',
                secondText:
                    '₹${formatPriceWithDecimal(widget.order.totalPrice)}',
                textSyle: textSyle,
                widget: widget),
            OrderSummaryTotal(
                firstText: 'Order Total:',
                secondText:
                    '₹${formatPriceWithDecimal(widget.order.totalPrice)}',
                headingTextSyle: headingTextSyle,
                widget: widget),
          ]),
        ),
      ],
    );
  }
}
