import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/you_might_also_like_single.dart';
import '../../../models/product.dart';

class YouMightAlsoLikeBlock extends StatelessWidget {
  const YouMightAlsoLikeBlock({
    super.key,
    required this.headingTextSyle,
    required this.categoryProductList,
  });

  final TextStyle headingTextSyle;
  final List<Product>? categoryProductList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You might also like',
          style: headingTextSyle,
        ),
        const SizedBox(
          height: 10,
        ),
        categoryProductList == null
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: categoryProductList!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      Product productData = categoryProductList![index];
                      return categoryProductList == null
                          ? const Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () {
                                navigateToProductDetails(
                                    context: context,
                                    product: productData,
                                    deliveryDate: 'Null for now');
                              },
                              child:
                                  YouMightAlsoLikeSingle(product: productData));
                    })),
              )
      ],
    );
  }
}
