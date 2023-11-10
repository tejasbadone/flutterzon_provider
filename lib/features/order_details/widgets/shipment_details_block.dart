import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/order_details/widgets/shipment_details.dart';
import 'package:amazon_clone_flutter/features/order_details/widgets/standard_delivery_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/user.dart';
import '../screens/order_details.dart';

class ShipmentDetailsBlock extends StatefulWidget {
  const ShipmentDetailsBlock({
    super.key,
    required this.containerDecoration,
    required this.textSyle,
    required this.user,
    required this.currentStep,
    required this.widget,
    required this.orderedProductRatings,
  });

  final BoxDecoration containerDecoration;
  final TextStyle textSyle;
  final User user;
  final int currentStep;
  final List<double> orderedProductRatings;
  final OrderDetailsScreen widget;

  @override
  State<ShipmentDetailsBlock> createState() => _ShipmentDetailsBlockState();
}

class _ShipmentDetailsBlockState extends State<ShipmentDetailsBlock> {
  @override
  Widget build(BuildContext context) {
    return widget.orderedProductRatings.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              StandardDeliveryContainer(
                  containerDecoration: widget.containerDecoration,
                  textSyle: widget.textSyle),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: widget.containerDecoration.copyWith(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.user.type == 'user'
                        ? ShipmentStatus(
                            currentStep: widget.currentStep,
                            textSyle: widget.textSyle)
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        for (int i = 0;
                            i < widget.widget.order.products.length;
                            i++)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToProductDetails(
                                        context: context,
                                        product:
                                            widget.widget.order.products[i],
                                        deliveryDate: getDeliveryDate());
                                  },
                                  child: Row(
                                    children: [
                                      Image.network(
                                        widget
                                            .widget.order.products[i].images[0],
                                        height: 110,
                                        width: 100,
                                        fit: BoxFit.contain,
                                        // width: 120,
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.widget.order.products[i]
                                                  .name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                'Qty. ${widget.widget.order.quantity[i]}'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        '₹${formatPrice(widget.widget.order.products[i].price)}',
                                        style: widget.textSyle
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Your rating',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  RatingBar.builder(
                                    itemSize: 28,
                                    initialRating:
                                        widget.orderedProductRatings[i] == -1
                                            ? 0
                                            : widget.orderedProductRatings[i],
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: GlobalVariables.secondaryColor,
                                    ),
                                    onRatingUpdate: (rating) {
                                      productDetailsServices.rateProduct(
                                          context: context,
                                          product:
                                              widget.widget.order.products[i],
                                          rating: rating);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          );
  }
}
