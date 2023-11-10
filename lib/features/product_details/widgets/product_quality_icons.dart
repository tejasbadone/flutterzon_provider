import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class ProductQualityIcons extends StatelessWidget {
  const ProductQualityIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: GlobalVariables.productQualityDetails.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            final iconMapPath =
                GlobalVariables.productQualityDetails[index]['iconName']!;
            final titleMapPath =
                GlobalVariables.productQualityDetails[index]['title']!;
            return SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/product_quality_icons/$iconMapPath',
                    height: 45,
                    width: 45,
                  ),
                  Text(
                    titleMapPath,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        letterSpacing: 0,
                        height: 0,
                        wordSpacing: 0,
                        color: GlobalVariables.selectedNavBarColor,
                        fontSize: 14),
                  )
                ],
              ),
            );
          })),
    );
  }
}
