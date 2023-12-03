import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handling.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/screens/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
        saveForLater: [],
        keepShoppingFor: [],
        wishList: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Account created! you can login now');
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      debugPrint(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              if (context.mounted) {
                Provider.of<UserProvider>(context, listen: false)
                    .setUser(res.body);
              }

              await prefs.setString(
                  'x-auth-token', jsonDecode(res.body)['token']);

              User user =
                  // ignore: use_build_context_synchronously
                  Provider.of<UserProvider>(context, listen: false).user;

              if (context.mounted) {
                if (user.type == 'admin') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AdminScreen.routeName, (route) => false);
                } else if (user.type == 'user') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, BottomBar.routeName, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AuthScreen.routeName, (route) => false);
                }

                showSnackBar(context, 'Sign in success');
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Future<User> getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        if (context.mounted) {
          userProvider.setUser(userRes.body);
        }
      }
      return userProvider.user;
    } catch (e) {
      User user = User(
          id: '',
          name: '',
          email: '',
          password: '',
          address: '',
          type: '',
          token: '',
          cart: [],
          saveForLater: [],
          keepShoppingFor: [],
          wishList: []);
      return user;
    }
  }
}
