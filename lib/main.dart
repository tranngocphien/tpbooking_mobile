import 'package:flutter/material.dart';
import 'package:tpbooking/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:tpbooking/screens/login/login_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => HomePageScreen(),
        },
        title: 'tpbooking',);
  }
}


