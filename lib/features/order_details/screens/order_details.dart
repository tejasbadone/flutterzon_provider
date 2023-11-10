import 'package:amazon_clone_flutter/common/widgets/custom_app_bar.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_clone_flutter/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone_flutter/features/product_details/widgets/divider_with_sizedbox.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../home/services/home_services.dart';
import '../widgets/order_summary_block.dart';
import '../widgets/payment_information_block.dart';
import '../widgets/shipment_details_block.dart';
import '../widgets/shipping_address_block.dart';
import '../widgets/track_update_shipment.dart';
import '../widgets/you_might_also_like_block.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';

  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  List<Product>? categoryProductList;
  int totalQuantity = 0;

  List<double> orderedProductRatings = [];

  double userRating = -1;

  final HomeServices homeServices = HomeServices();
  final AdminServices adminServices = AdminServices();
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  int getProductsQuantity() {
    for (int i = 0; i < widget.order.quantity.length; i++) {
      totalQuantity += widget.order.quantity[i];
    }
    return totalQuantity;
  }

  @override
  void initState() {
    super.initState();
    getCategoryProducts();
    getProductsQuantity();
    getProductRating();
    currentStep = widget.order.status;
  }

  getProductRating() async {
    for (int i = 0; i < widget.order.products.length; i++) {
      double tempRating = await productDetailsServices.getRating(
          context: context, product: widget.order.products[i]);

      orderedProductRatings.add(tempRating);
    }

    setState(() {});
  }

  getCategoryProducts() async {
    categoryProductList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.order.products[0].category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    final BoxDecoration containerDecoration = BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8));

    const TextStyle textSyle = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15);

    const TextStyle headingTextSyle = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View order details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 90,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: containerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Order date        ${formatDate(widget.order.orderedAt)}',
                        style: textSyle,
                      ),
                      Text('Order #              ${widget.order.id}',
                          style: textSyle),
                      Text(
                          'Order total        ₹${formatPrice(widget.order.totalPrice)}',
                          style: textSyle),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Shipment details', style: headingTextSyle),
            const SizedBox(
              height: 6,
            ),
            orderedProductRatings.length != widget.order.products.length
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ShipmentDetailsBlock(
                    containerDecoration: containerDecoration,
                    textSyle: textSyle,
                    user: user,
                    currentStep: currentStep,
                    widget: widget,
                    orderedProductRatings: orderedProductRatings,
                  ),
            TrackUpdateShipment(widget: widget, user: user, textSyle: textSyle),
            const DividerWithSizedBox(
              thickness: 1,
              sB1Height: 0,
              sB2Height: 0,
            ),
            PaymentInformationBlock(
                headingTextSyle: headingTextSyle,
                containerDecoration: containerDecoration,
                textSyle: textSyle,
                user: user),
            const SizedBox(
              height: 8,
            ),
            ShippingAddressBlock(
                headingTextSyle: headingTextSyle,
                containerDecoration: containerDecoration,
                user: user,
                textSyle: textSyle),
            const SizedBox(
              height: 8,
            ),
            OrderSummaryBlock(
              headingTextSyle: headingTextSyle,
              containerDecoration: containerDecoration,
              totalQuantity: totalQuantity,
              textSyle: textSyle,
              widget: widget,
            ),
            const SizedBox(
              height: 20,
            ),
            user.type == 'admin'
                ? const SizedBox()
                : YouMightAlsoLikeBlock(
                    headingTextSyle: headingTextSyle,
                    categoryProductList: categoryProductList)
          ],
        ),
      )),
    );
  }
}
