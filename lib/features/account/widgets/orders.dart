import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/features/account/screens/your_orders.dart';
import 'package:amazon_clone_flutter/features/account/services/account_services.dart';
import 'package:amazon_clone_flutter/features/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';
import '../../../models/order.dart';
import 'single_product.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    orders = orders!.reversed.toList();
    if (context.mounted) {
      setState(() {});
    }
  }

  void navigateToOrderDetailsScreen(Order order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
        arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, YourOrders.routeName),
                  child: Text(
                    'See all',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: GlobalVariables.selectedNavBarColor),
                  ))
            ],
          ),
          orders == null
              ? SizedBox(
                  height: 170,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black12, width: 1.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      }),
                )
              : SizedBox(
                  height: 170,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () =>
                              navigateToOrderDetailsScreen(orders![index]),
                          child: Container(
                              width: 200,
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: orders![index].products.length == 1
                                  ? SingleProduct(
                                      image:
                                          orders![index].products[0].images[0],
                                    )
                                  : Row(
                                      children: [
                                        SingleProduct(
                                          image: orders![index]
                                              .products[0]
                                              .images[0],
                                        ),
                                        Text(
                                          '+ ${orders![index].products.length - 1}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade500,
                                          ),
                                        )
                                      ],
                                    )),
                        );
                      }),
                )
        ],
      ),
    );
  }
}
