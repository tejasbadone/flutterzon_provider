import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/features/admin/models/sales.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/order.dart';

class AdminServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinaryCloudName = dotenv.env['CLOUDINARY_CLOUDNAME'];
      final cloudinaryUploadPreset = dotenv.env['CLOUDINARY_UPLOADPRESET'];

      final cloudinary =
          CloudinaryPublic(cloudinaryCloudName!, cloudinaryUploadPreset!);

      List<String> imageUrls = [];

      String folderName = formatFolderName(name);

      String folder = 'products/$category/$folderName';

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: folder),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: product.toJson(),
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
            onSuccess();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, '${e.toString()} + from admin_services.dart');
      }
    }
  }

  Future<List<Product>> fetchAllProducts(
    BuildContext context,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                productList.add(
                  Product.fromJson(
                    jsonEncode(
                      jsonDecode(res.body)[i],
                    ),
                  ),
                );
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }

    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      if (context.mounted) {
        httpErrorHandle(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context,
            '${e.toString()} from admin_services.dart -> deleteProduct');
      }
    }
  }

  Future<List<Order>> fetchaAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-orders"),
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
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                orderList.add(
                  Order.fromJson(
                    jsonEncode(
                      jsonDecode(res.body)[i],
                    ),
                  ),
                );
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }

    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required Order order,
      required int status,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/change-order-status"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'id': order.id,
                'status': status,
              }));

      if (context.mounted) {
        httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/analytics"),
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
              var response = jsonDecode(res.body);
              totalEarning = response['totalEarnings'];

              sales = [
                Sales('Mobiles', response['mobileEarnings'] ?? 0),
                Sales('Fashion', response['fashionEarnings'] ?? 0),
                Sales('Electronics', response['electronicsEarnings'] ?? 0),
                Sales('Home', response['homeEarnings'] ?? 0),
                Sales('Beauty', response['beautyEarnings'] ?? 0),
                Sales('Appliances', response['appliancesEarnings'] ?? 0),
                Sales('Grocery', response['groceryEarnings'] ?? 0),
                Sales('Books', response['booksEarnings'] ?? 0),
                Sales('Essentials', response['essentialsEarnings'] ?? 0),
              ];
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> categoryProducts = [];

    try {
      http.Response res = await http.get(
          Uri.parse("$uri/admin/get-category-product/$category"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                categoryProducts.add(
                  Product.fromJson(
                    jsonEncode(
                      jsonDecode(res.body)[i],
                    ),
                  ),
                );
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return categoryProducts;
  }
}
