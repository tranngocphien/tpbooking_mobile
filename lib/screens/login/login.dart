import 'package:flutter/material.dart';
import 'package:tpbooking/screens/login/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              'assets/images/TPBOOKING.png',
              width: 240,
              height: 240,
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: TextField(
                      controller: _usernameController,
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(24))),
                          hintText: 'Username',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF34e3a6), width: 2.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(24)))),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextField(
                      controller: _passwordController,
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF34e3a6), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)))),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      LoginController loginController = Get.find();
                      loginController.login(_usernameController.text, _passwordController.text);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 64,
                      decoration: const BoxDecoration(
                          color: Color(0xFF18b57e),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: const Center(
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
