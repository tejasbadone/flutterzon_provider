import 'package:amazon_clone_flutter/common/widgets/custom_app_bar.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';
import '../services/admin_services.dart';
import '../widgets/custom_floating_action_button.dart';

class CategoryProductsScreenAdmin extends StatefulWidget {
  static const String routeName = 'category-product-screen-admin';

  const CategoryProductsScreenAdmin({super.key, required this.category});
  final String category;

  @override
  State<CategoryProductsScreenAdmin> createState() =>
      _CategoryProductsScreenAdminState();
}

class _CategoryProductsScreenAdminState
    extends State<CategoryProductsScreenAdmin> {
  final AdminServices adminServices = AdminServices();
  List<Product>? productsInitial;
  List<Product>? products;

  fetchCategoryProducts() async {
    productsInitial = await adminServices.getCategoryProducts(
        context: context, category: widget.category);
    products = productsInitial!.reversed.toList();
    setState(() {});
  }

  goToProductPage(Product productData) {
    Map<String, dynamic> arguments = {
      'product': productData,
      'deliveryDate': getDeliveryDate(),
    };

    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: arguments);
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return InkWell(
                        onTap: () => goToProductPage(productData),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child:
                                    SingleProduct(image: productData.images[0]),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        productData.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: IconButton(
                                        onPressed: () =>
                                            deleteProduct(productData, index),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
