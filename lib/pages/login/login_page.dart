import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/login/edit_text.dart';
import 'package:salesoft_hrm/pages/login/login_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final userPasswordController = TextEditingController(
      text: controller.password.value,
    );
    final userUserNameController = TextEditingController(
      text: controller.userName.value,
    );

    Get.put(AuthService());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AppResource.icLogoVNPT,
              height: 156,
            ),
            Obx(() => EditText(
                  title: 'Mã đăng nhập',
                  value: controller.userName.value,
                  controllerTF: userUserNameController,
                  onChange: (value) {
                    controller.userName.value = value;
                  },
                  errorMessage: controller.userNameError.value,
                )),
            AppConstant.spaceVerticalSmallMedium,
            Obx(() => EditText(
                  title: "Mật khẩu",
                  value: controller.password.value,
                  onChange: (value) {
                    controller.password.value = value;
                  },
                  isHideValue: controller.getPasswordVisible(),
                  controllerTF: userPasswordController,
                  suffix: InkWell(
                    onTap: () => controller.togglePassword(),
                    child: Text(
                      controller.passwordVisible.value ? "HIỆN" : "ẨN",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey300,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  errorMessage: controller.passwordError.value,
                )),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final username = controller.userName.value;
                final password = controller.password.value;
                if (!controller.isValidateInfo()) {
                  controller.setErrors();
                  return;
                }
                final authService = Get.find<AuthService>();
                final loggedIn = await authService.login(username, password);
                if (loggedIn) {
                  controller.clearPassword();
                  userPasswordController.clear();
                  _loginOnClick(context);
                } else {
                  Get.snackbar('Lỗi', 'Sai thông tin đăng nhập',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginOnClick(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1500),
        pageBuilder: (_, __, ___) => MainPage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
