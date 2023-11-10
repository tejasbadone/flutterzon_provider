import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/cart_offers_provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/rate-product"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({'id': product.id!, 'rating': rating}));

      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: () {});
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<double> getRating(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    double rating = -1.0;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/get-product-rating/${product.id}"),
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
            rating = jsonDecode(res.body).toDouble();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, '${e.toString()} from product_services');
      }
    }
    return rating;
  }

  Future<double> getAverageRating(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    double averageRating = 0;
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/get-ratings-average/${product.id}"),
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
              if (jsonDecode(res.body) != 0 && jsonDecode(res.body) != null) {
                averageRating = jsonDecode(res.body).toDouble();
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(
            context, '${e.toString()} from product_services -> getAvgRating');
      }
    }

    return averageRating;
  }

  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final category = Provider.of<CartOfferProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
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

            category.setCategory1(product.category.toString());
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
