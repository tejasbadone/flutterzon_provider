import 'dart:convert';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'address': address,
          },
        ),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
                address: jsonDecode(res.body)['address'],
                wishList: jsonDecode(res.body)['wishList'],
                cart: jsonDecode(res.body)['cart'],
                keepShoppingFor: jsonDecode(res.body)['keepShoppingFor'],
                saveForLater: jsonDecode(res.body)['saveForLater'],
              );

              userProvider.setUserFromModel(user);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
                cart: [],
                wishList: jsonDecode(res.body)['wishList'],
                keepShoppingFor: jsonDecode(res.body)['keepShoppingFor'],
                saveForLater: jsonDecode(res.body)['saveForLater']);
            userProvider.setUserFromModel(user);
            showSnackBar(context, 'Your order has been placed!');
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void placeOrderBuyNow(
      {required BuildContext context,
      required Product product,
      required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/api/place-order-buy-now"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode(
                {
                  'id': product.id,
                  'totalPrice': product.price,
                  'address': address,
                },
              ));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Your order has been placed! ');
              Navigator.of(context).pop();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
