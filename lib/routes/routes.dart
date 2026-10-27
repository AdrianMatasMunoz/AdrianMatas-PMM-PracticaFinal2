import 'package:flutter/material.dart';
import 'package:practica_final_2/screens/screens.dart';

class Routes {
  static const String initialRoute = "/";
  static final Map<String, WidgetBuilder> routes = {
    "/": (BuildContext context) => const HomeScreen(),
    "/personal": (BuildContext context) => const PersonalScreen(),
    "/widget": (BuildContext context) => const WidgetScreen()
  };

  //static Map<String, WidgetBuilder> getRoutes() => _routes;
}