import 'package:flutter/material.dart';

import '../../../common/widgets/you_might_also_like_single.dart';
import '../../../models/product.dart';
import '../screens/product_details_screen.dart';

class YouMightAlsoLike extends StatelessWidget {
  const YouMightAlsoLike({
    super.key,
    required this.categoryProductList,
    required this.deliveryDate,
  });

  final List<Product>? categoryProductList;
  final String deliveryDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You might also like',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        categoryProductList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProductList!.length,
                    itemBuilder: ((context, index) {
                      Product productData = categoryProductList![index];

                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: {
                                  'product': productData,
                                  'deliveryDate': deliveryDate,
                                });
                          },
                          child: YouMightAlsoLikeSingle(product: productData));
                    })),
              ),
      ],
    );
  }
}
