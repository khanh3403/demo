import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/pages/Home/home_page.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkLoginStatus();
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void _checkLoginStatus() async {
    final authService = Get.find<AuthService>();
    final isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      Get.offAll(() => MainPage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }
}
