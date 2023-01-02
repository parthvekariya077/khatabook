import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/view/homeScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {'/': (context) => MyApp()},
  ));
}
