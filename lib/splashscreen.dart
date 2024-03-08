import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tambal_ban/home_page.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      cekPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/app_logo.jpg",
              scale: 2,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Tambal Ban",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const CupertinoActivityIndicator()
          ],
        ),
      ),
    );
  }

  void cekPermission() async {
    PermissionStatus status = await Permission.location.request();
    log(status.toString());
    if (status == PermissionStatus.granted) {
      Get.to(() => const HomePage());
    } else {
      Get.snackbar(
          "Maaf", "Harap izinkan penggunaan Lokasi Anda Terlebih dahulu");
    }
  }
}
