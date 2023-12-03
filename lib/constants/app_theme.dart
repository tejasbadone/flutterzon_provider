import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      fontFamily: 'AmazonEmber',
      scaffoldBackgroundColor: GlobalVariables.backgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          modalBackgroundColor: Colors.white),
      colorScheme:
          const ColorScheme.light(primary: GlobalVariables.secondaryColor),
      appBarTheme: const AppBarTheme(
          elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
      useMaterial3: true,
    );
  }
}
