import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:flutter/material.dart';

import '../../../constants/utils.dart';
import 'single_top_category_item.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(gradient: GlobalVariables.goldenGradient),
      child: Center(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: GlobalVariables.categoryImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateToCategoryPage(
                    context, GlobalVariables.categoryImages[index]['title']!),
                child: SingleTopCategoryItem(
                  title: GlobalVariables.categoryImages[index]['title']!,
                  image: GlobalVariables.categoryImages[index]['image']!,
                ),
              );
            }),
      ),
    );
  }
}
