import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Sales {
  final String label;
  final int earning;
  final Color pointColor = GlobalVariables.secondaryColor;

  Sales(this.label, this.earning);
}
