import 'package:flutter/material.dart';
import 'package:india_cart_app/core/store.dart';
import 'package:india_cart_app/pages/cart_page.dart';
import 'package:india_cart_app/pages/login_page.dart';
import 'package:india_cart_app/utils/routes.dart';
import 'package:india_cart_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'pages/home_page.dart';

void main() {
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.cartPage: (context) => CartPage(),
      },
    );
  }
}
