import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';

class ShippingAddressBlock extends StatelessWidget {
  const ShippingAddressBlock({
    super.key,
    required this.headingTextSyle,
    required this.containerDecoration,
    required this.user,
    required this.textSyle,
  });

  final TextStyle headingTextSyle;
  final BoxDecoration containerDecoration;
  final User user;
  final TextStyle textSyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping Address', style: headingTextSyle),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: containerDecoration,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              capitalizeFirstLetter(string: user.name),
              style: textSyle.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              user.address,
              style: textSyle.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            )
          ]),
        ),
      ],
    );
  }
}
