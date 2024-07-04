import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final authService = Get.find<AuthService>();
    final isLoggedIn = await authService.isLoggedIn();
    Get.offAll(() => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppResource.icBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    AppResource.icPMC,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                ScaleTransition(
                  scale: _animation,
                  child: const Text(
                  
                    'PMC CHECKLIST',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
