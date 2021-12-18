import 'package:flutter/material.dart';
import 'package:tpbooking/screens/home/home_screen.dart';
import 'package:tpbooking/screens/hotel/hotel_screen.dart';
import 'package:tpbooking/screens/list_hotel/list_hotel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => HomePageScreen(),
        },
        title: 'tpbooking',);
  }
}


