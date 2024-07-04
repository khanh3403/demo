import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/main.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/pages/login/edit_text.dart';
import 'package:salesoft_hrm/pages/login/login_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checkToken =false;
    final controller = Get.put(LoginController());
    final userPasswordController = TextEditingController(
      text: controller.password.value,
    );
    final userUserNameController = TextEditingController(
      text: controller.userName.value,
    );

    Get.put(AuthService());
    Get.put(HomeController());
    final mainController = Get.put(MainController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppResource.icBackground),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppConstant.getScreenSizeHeight(context) * 0.2),
              Image.asset(
                AppResource.icPMC,
                fit: BoxFit.fitHeight,
                height: AppConstant.getScreenSizeHeight(context) * 0.13,
              ),
              SizedBox(height: AppConstant.getScreenSizeHeight(context) * 0.03),
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
              AppConstant.spaceVerticalSmallMedium,
              CupertinoButton(
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
                    Get.find<HomeController>().fetchUserInfo();
                    mainController.pageIndex.value = 0; 
                    Get.snackbar('Thông báo', 'Đăng nhập thành công.',
                        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blueVNPT);
                    _loginOnClick(context);
                      await postToken(username, deviceToken.value);
                    if(checkToken==true){
                    SharedPreferences pref = await SharedPreferences.getInstance();
                     checkToken= await pref.setString('deviceToken', deviceToken.value);
                   
                    // print('Token saved: $checkToken');
                    }
                    else{
                      print('đã lưu token');
                    }

                  } else {
              _showPermissionDeniedDialog(context);
                  }
                },  
                color: AppColors.blueVNPT,
                child: Text('Đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> postToken(String ma, String token) async {
     final urlEndPoint =
        "${URLHelper.NS_Token}?Ma=$ma&Token=$token";
    final response = await HttpUtil().post(
      urlEndPoint,
      params: {'Ma': ma, 'Token': token},
    );
    if (response.statusCode == 200) {
      print('Đã đẩy lên API');
    } else {
      print('Lỗi khi đẩy lên API: ${response.statusCode}');
    }
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

  void _showPermissionDeniedDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Image.asset(
            AppResource.icWarning, 
            height: 80,
            width: 80,
          ),
          content: Text('Sai thông tin đăng nhập.'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
