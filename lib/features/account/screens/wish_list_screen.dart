import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../widgets/single_wish_list_product.dart';

class WishListScreen extends StatefulWidget {
  static const String routeName = '/wish-list-screen';

  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
                'Your Wish List',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              userProvider.user.wishList.isEmpty
                  ? const Center(
                      child: Text(
                        'Your wishlist is empty.',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userProvider.user.wishList.length,
                      itemBuilder: ((context, index) {
                        Product product = Product.fromMap(
                            userProvider.user.wishList[index]['product']);

                        return SingleWishListProduct(
                            product: product, deliveryDate: getDeliveryDate());
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
