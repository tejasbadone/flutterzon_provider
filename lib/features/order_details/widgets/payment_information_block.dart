import 'package:flutter/material.dart';

import '../../../models/user.dart';

class PaymentInformationBlock extends StatelessWidget {
  const PaymentInformationBlock({
    super.key,
    required this.headingTextSyle,
    required this.containerDecoration,
    required this.textSyle,
    required this.user,
  });

  final TextStyle headingTextSyle;
  final BoxDecoration containerDecoration;
  final TextStyle textSyle;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment information',
          style: headingTextSyle,
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            alignment: Alignment.centerLeft,
            decoration: containerDecoration.copyWith(
              border: const Border(
                left: BorderSide(color: Colors.black12, width: 1),
                right: BorderSide(color: Colors.black12, width: 1),
                top: BorderSide(color: Colors.black12, width: 1),
                // bottom: BorderSide(color: Colors.black12, width: 0)
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: textSyle.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Google Pay',
                  style: textSyle.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: containerDecoration.copyWith(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing Address',
                style: textSyle.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Text(
                user.address,
                style: textSyle.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
