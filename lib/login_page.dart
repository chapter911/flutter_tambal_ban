import 'package:flutter/material.dart';
import 'package:flutter_tambal_ban/helper/api.dart';
import 'package:flutter_tambal_ban/register.dart';
import 'package:flutter_tambal_ban/style/style.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/app_logo.jpg',
              scale: 3,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _username,
                    decoration: Style().dekorasiInput(
                      hint: "username",
                      icon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: Style().dekorasiInput(
                      hint: "password",
                      icon: const Icon(Icons.vpn_key),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Api.postData(
                          context, "https://tambal.agungj.com/bengkel/login", {
                        "username": _username.text,
                        "password": _password.text,
                      }).then((value) {
                        if (value!.status == "success") {
                          Get.to(
                            () => const RegisterPage(),
                            arguments: value.data,
                          );
                        }
                      });
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const RegisterPage());
                    },
                    child: const Text("register"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
