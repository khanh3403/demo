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

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkToken = false;
  bool rememberMe = false;
  bool isLoading = false;
  final controller = Get.put(LoginController());
  late TextEditingController userPasswordController;
  late TextEditingController userUserNameController;

  @override
  void initState() {
    super.initState();
    userPasswordController = TextEditingController();
    userUserNameController = TextEditingController();
    _loadRememberedLogin();
  }

  @override
  void dispose() {
    userPasswordController.dispose();
    userUserNameController.dispose();
    super.dispose();
  }

  void _loadRememberedLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? rememberMe = pref.getBool('rememberMe');
    if (rememberMe != null && rememberMe) {
      String? username = pref.getString('username');
      String? password = pref.getString('password');
      if (username != null && password != null) {
        setState(() {
          userUserNameController.text = username;
          userPasswordController.text = password;
          this.rememberMe = rememberMe;
          controller.userName.value = username;
          controller.password.value = password;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthService());
    Get.put(HomeController());
    final mainController = Get.put(MainController());

    return Scaffold(
      body: GestureDetector(
         onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            activeColor: AppColors.blueVNPT, 
              checkColor: Colors.white, 
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                              SharedPreferences.getInstance().then((pref) {
                                if (rememberMe) {
                                  pref.setString('username', controller.userName.value);
                                  pref.setString('password', controller.password.value);
                                } else {
                                  pref.remove('username');
                                  pref.remove('password');
                                }
                                pref.setBool('rememberMe', rememberMe);
                              });
                            },
                          ),
                          const Text(
                            'Nhớ tài khoản',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppConstant.spaceVerticalSmallMedium,
                isLoading 
                    ? Center(child: CircularProgressIndicator())
                    : CupertinoButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true; 
                          });
                          final username = controller.userName.value;
                          final password = controller.password.value;
                          if (!controller.isValidateInfo()) {
                            controller.setErrors();
                            setState(() {
                              isLoading = false; 
                            });
                            return;
                          }
                          final authService = Get.find<AuthService>();
                          final loggedIn = await authService.login(username, password);
                          setState(() {
                            isLoading = false; 
                          });
                          if (loggedIn) {
                            controller.clearPassword();
                            userPasswordController.clear();
                            Get.find<HomeController>().fetchUserInfo();
                            mainController.pageIndex.value = 0;
                            Get.snackbar('Thông báo', 'Đăng nhập thành công.',
                                snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blueVNPT);
                            _loginOnClick(context);
                            await postToken(username, deviceToken.value);
                            if (checkToken) {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              checkToken = await pref.setString('deviceToken', deviceToken.value);
                            } else {
                              print('đã lưu token');
                            }
        
                            if (rememberMe) {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await pref.setString('username', username);
                              await pref.setString('password', password);
                              await pref.setBool('rememberMe', rememberMe);
                            } else {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await pref.remove('rememberMe');
                              await pref.remove('username');
                              await pref.remove('password');
                            }
                          } else {
                            _showPermissionDeniedDialog(context);
                          }
                        },
                        color: AppColors.blueVNPT,
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postToken(String ma, String token) async {
    final urlEndPoint = "${URLHelper.NS_Token}?Ma=$ma&Token=$token";
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
