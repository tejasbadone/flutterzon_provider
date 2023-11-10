// import 'package:amazon_clone_flutter/common/widgets/bottom_bar.dart';
// import 'package:amazon_clone_flutter/features/admin/screens/bottom_bar.dart';
// import 'package:amazon_clone_flutter/features/auth/screens/auth_screen.dart';
// import 'package:amazon_clone_flutter/features/auth/services/auth_service.dart';
// import 'package:amazon_clone_flutter/providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({
//     super.key,
//   });

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthService authService = AuthService();
//   @override
//   void initState() {
//     super.initState();
//     authService.getUserData(context);
//     splashScreen();
//   }

//   redirectScreen(Widget redirectScreen) {
//     // Future.delayed(const Duration(seconds: 2), () {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => redirectScreen));
//     // }
//     // );
//   }

//   splashScreen() async {
//     final user = Provider.of<UserProvider>(context).user;

//     debugPrint(user.token.toString());

//     Provider.of<UserProvider>(context).user.token.isNotEmpty
//         ? user.type == 'user'
//             ? redirectScreen(const BottomBar())
//             : redirectScreen(const AdminScreen())
//         : redirectScreen(const AuthScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Image.asset(
//         'assets/images/amazon_in_alt.png',
//         height: 52,
//       )),
//     );
//   }
// }
