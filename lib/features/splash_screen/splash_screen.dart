import 'package:amazon_clone_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/admin/screens/bottom_bar.dart';
import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService().getUserData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration.zero, () {
              if (snapshot.data!.type == 'admin') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()));
              } else if (snapshot.data!.type == 'user') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const BottomBar()));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthScreen()));
              }
            });

            return Center(
                child: Image.asset(
              'assets/images/amazon_in_alt.png',
              height: 52,
            ));
          } else {
            return Center(
                child: Image.asset(
              'assets/images/amazon_in_alt.png',
              height: 52,
            ));
          }
        },
      ),
    );
  }
}

late final User user;
