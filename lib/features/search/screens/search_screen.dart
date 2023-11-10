import 'package:amazon_clone_flutter/features/home/widgets/address_bar.dart';
import 'package:amazon_clone_flutter/common/widgets/single_listing_product.dart';
import 'package:amazon_clone_flutter/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone_flutter/features/search/services/search_services.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async {
    products = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return products == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(),
            ),
            body: products == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      user.address != ''
                          ? const AddressBar()
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: products!.length,
                            itemBuilder: ((context, index) {
                              final product = products![index];

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ProductDetailsScreen.routeName,
                                        arguments: product);
                                  },
                                  child: SingleListingProduct(
                                    product: product,
                                    deliveryDate: getDeliveryDate(),
                                  ));
                            })),
                      )
                    ],
                  ),
          );
  }
}
