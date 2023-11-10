import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../screens/order_details.dart';
import '../screens/tracking_details_sceen.dart';

class TrackUpdateShipment extends StatelessWidget {
  const TrackUpdateShipment({
    super.key,
    required this.widget,
    required this.user,
    required this.textSyle,
  });

  final OrderDetailsScreen widget;
  final User user;
  final TextStyle textSyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, TrackingDetailsScreen.routeName,
                arguments: widget.order);
          },
          title: Text(
            user.type == 'user' ? 'Track shipment' : 'Update shipment (admin)',
            style: user.type == 'user'
                ? textSyle
                : textSyle.copyWith(color: GlobalVariables.greenColor),
          ),
          style: ListTileStyle.list,
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: user.type == 'user'
                ? Colors.black87
                : GlobalVariables.greenColor,
          ),
        ),
      ],
    );
  }
}
