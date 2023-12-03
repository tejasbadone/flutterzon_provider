import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration:
          const BoxDecoration(gradient: GlobalVariables.addressBarGradient),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Deliver to ${capitalizeFirstLetter(string: user.name)} - ${user.address}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          const Icon(
            Icons.expand_more,
            size: 20,
          ),
        ],
      ),
    );
  }
}
