import 'package:amazon_clone_flutter/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../common/widgets/single_listing_product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';

  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    productList!.shuffle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: productList == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 0.4)),
                  child: Text(
                    'Over ${productList!.length} Results in ${widget.category}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: productList!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        final deliveryDate = getDeliveryDate();

                        return SingleListingProduct(
                          product: product,
                          deliveryDate: deliveryDate,
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
