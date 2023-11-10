import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/home/screens/category_deals_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class BottomOffers extends StatelessWidget {
  const BottomOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 4, right: 0),
        itemCount: GlobalVariables.bottomOfferImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          // if (index == 0) {
          //   return const Row(
          //     children: [
          //       SingleBottomOffer(
          //         mapName: GlobalVariables.bottomOffersAmazonPay,
          //       ),
          //     ],
          //   );
          // } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                if (GlobalVariables.bottomOfferImages[index]['category'] ==
                    'AmazonPay') {
                  if (context.mounted) {
                    showSnackBar(context, 'Amazon Pay coming soon!');
                  }
                } else {
                  Navigator.pushNamed(context, CategoryDealsScreen.routeName,
                      arguments: GlobalVariables.bottomOfferImages[index]
                          ['category']);
                }
              },
              child: CachedNetworkImage(
                imageUrl: GlobalVariables.bottomOfferImages[index]['image']!,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
          // }
        }),
      ),
    );
  }
}
