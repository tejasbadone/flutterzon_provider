import 'package:amazon_clone_flutter/constants/app_theme.dart';
import 'package:amazon_clone_flutter/features/splash_screen/splash_screen.dart';
import 'package:amazon_clone_flutter/providers/cart_offers_provider.dart';
import 'package:amazon_clone_flutter/providers/screen_number_provider.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:amazon_clone_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'constants/utils.dart';

Future main() async {
  await dotenv.load(fileName: "config.env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ScreenNumberProvider()),
    ChangeNotifierProvider(create: (context) => CartOfferProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheAllImage(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const SplashScreen());
  }
}
