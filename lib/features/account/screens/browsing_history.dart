import 'package:amazon_clone_flutter/common/widgets/custom_app_bar.dart';
import 'package:amazon_clone_flutter/common/widgets/single_listing_product.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class BrowsingHistory extends StatelessWidget {
  static const String routeName = '/browsing-history';

  const BrowsingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Browsing History',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              userProvider.user.keepShoppingFor.isEmpty
                  ? const Center(
                      child: Text(
                        'Your browsing history is empty.',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    )
                  : Column(
                      children: [
                        const Text(
                          'These items were viewed recently, We use them to personalise recommendations.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                userProvider.user.keepShoppingFor.length > 40
                                    ? 40
                                    : userProvider.user.keepShoppingFor.length,
                            itemBuilder: ((context, index) {
                              Product product = Product.fromMap(userProvider
                                  .user.keepShoppingFor[index]['product']);

                              return SingleListingProduct(
                                  product: product,
                                  deliveryDate: getDeliveryDate());
                            }))
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
