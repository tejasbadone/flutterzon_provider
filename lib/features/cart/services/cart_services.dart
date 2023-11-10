import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/utils.dart';
import '../../../models/user.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
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

  void deleteFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/delete-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
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

  void saveForLater(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/save-for-later"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!,
          }));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
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

  void deleteFromLater(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/delete-from-later/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
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

  void moveToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/move-to-cart"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id!,
          }));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
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
}
