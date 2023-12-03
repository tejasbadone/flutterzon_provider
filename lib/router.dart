import 'package:amazon_clone_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/account/screens/account_screen.dart';
import 'package:amazon_clone_flutter/features/account/screens/search_orders_screen.dart';
import 'package:amazon_clone_flutter/features/account/screens/wish_list_screen.dart';
import 'package:amazon_clone_flutter/features/account/screens/your_orders.dart';
import 'package:amazon_clone_flutter/features/address/screens/address_screen.dart';
import 'package:amazon_clone_flutter/features/address/screens/address_screen_buy_now.dart';
import 'package:amazon_clone_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone_flutter/features/admin/screens/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone_flutter/features/home/screens/home_screen.dart';
import 'package:amazon_clone_flutter/features/menu/screens/menu_screen.dart';
import 'package:amazon_clone_flutter/features/order_details/screens/tracking_details_sceen.dart';
import 'package:amazon_clone_flutter/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone_flutter/features/search/screens/search_screen.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';

import 'features/account/screens/browsing_history.dart';
import 'features/admin/screens/category_products_screen_admin.dart';
import 'features/order_details/screens/order_details.dart';
import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: routeSettings);

    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const HomeScreen(), settings: routeSettings);

    case BottomBar.routeName:
      return MaterialPageRoute(
          builder: (_) => const BottomBar(), settings: routeSettings);

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AddProductScreen(), settings: routeSettings);

    case AccountScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AccountScreen(), settings: routeSettings);

    case MenuScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const MenuScreen(), settings: routeSettings);

    case YourOrders.routeName:
      return MaterialPageRoute(
          builder: (_) => const YourOrders(), settings: routeSettings);

    case BrowsingHistory.routeName:
      return MaterialPageRoute(
          builder: (_) => const BrowsingHistory(), settings: routeSettings);

    case AdminScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AdminScreen(), settings: routeSettings);

    case WishListScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const WishListScreen(), settings: routeSettings);

    case CartScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const CartScreen(), settings: routeSettings);

    case CategoryProductsScreenAdmin.routeName:
      var category = routeSettings.arguments as String;

      return MaterialPageRoute(
          builder: (_) => CategoryProductsScreenAdmin(
                category: category,
              ),
          settings: routeSettings);

    case AddressScreenBuyNow.routeName:
      var product = routeSettings.arguments as Product;

      return MaterialPageRoute(
          builder: (_) => AddressScreenBuyNow(
                product: product,
              ),
          settings: routeSettings);

    case TrackingDetailsScreen.routeName:
      Order order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          builder: (_) => TrackingDetailsScreen(order: order),
          settings: routeSettings);

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => AddressScreen(totalAmount: totalAmount),
          settings: routeSettings);

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ),
          settings: routeSettings);

    case SearchOrderScreeen.routeName:
      var orderQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchOrderScreeen(orderQuery: orderQuery),
          settings: routeSettings);

    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          builder: (_) => OrderDetailsScreen(
                order: order,
              ),
          settings: routeSettings);

    case ProductDetailsScreen.routeName:
      Map<String, dynamic> arguments =
          routeSettings.arguments as Map<String, dynamic>;
      Product product = arguments['product'];
      String deliveryDate = arguments['deliveryDate'];
      return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
                arguments: {'product': product, 'deliveryDate': deliveryDate},
              ),
          settings: routeSettings);

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
                category: category,
              ),
          settings: routeSettings);

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Screen does not exist!')),
              ));
  }
}
