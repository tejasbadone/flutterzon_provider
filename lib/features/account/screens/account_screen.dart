import 'package:amazon_clone_flutter/features/account/services/account_services.dart';
import 'package:amazon_clone_flutter/features/account/widgets/name_bar.dart';
import 'package:amazon_clone_flutter/features/product_details/widgets/divider_with_sizedbox.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/account_screen_app_bar.dart';
import '../widgets/keep_shopping_for.dart';
import '../widgets/orders.dart';
import '../widgets/top_buttons.dart';
import '../widgets/wish_list.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account-screen';

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

List<Order>? orders;
final AccountServices accountServices = AccountServices();

class _AccountScreenState extends State<AccountScreen> {
  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    orders = orders!.reversed.toList();
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AccuntScreenAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  const Positioned(top: 0, child: NameBar()),
                  Positioned(
                      top: 50,
                      child: Container(
                        height: 80,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.9)
                              ],
                              stops: const [
                                0,
                                0.45
                              ],
                              begin: AlignmentDirectional.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      )),
                  Positioned(
                    top: 60,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 200,
                        width: MediaQuery.sizeOf(context).width,
                        child: const TopButtons()),
                  ),
                ],
              ),
            ),
            orders == null || orders!.isEmpty
                ? const SizedBox()
                : const Orders(),
            const DividerWithSizedBox(
              thickness: 4,
              sB1Height: 15,
              sB2Height: 0,
            ),
            userProvider.user.keepShoppingFor.isNotEmpty
                ? const Column(
                    children: [
                      KeepShoppingFor(),
                      DividerWithSizedBox(
                        thickness: 4,
                        sB1Height: 15,
                        sB2Height: 4,
                      ),
                    ],
                  )
                : const SizedBox(),
            userProvider.user.wishList.isNotEmpty
                ? const WishList()
                : const SizedBox(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
