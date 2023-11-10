import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../../features/home/widgets/search_text_form_field.dart';
import '../../features/search/screens/search_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration:
            const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      ),
      title: SearchTextFormField(onTapSearchField: (String query) {
        Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
      }),
    );
  }
}
