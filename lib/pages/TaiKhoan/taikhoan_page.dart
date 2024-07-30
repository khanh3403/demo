import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/doimk_provider.dart';
import 'package:salesoft_hrm/API/repository/doimk_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaiKhoanPage extends StatelessWidget {
  const TaiKhoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _profile(),
          SizedBox(
            height: AppConstant.getScreenSizeHeight(context) * 0.05,
          ),
          
         
          
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: GestureDetector(
              onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangePasswordDialog();
                  },
                );
              },
              child: const Row(
                children: [
                  Expanded(
                    flex:15,
                    child: FaIcon(
                      FontAwesomeIcons.lock,
                      color: AppColors.orBgr,
                      size: 30,
                    ),
                  ),
                  
                  Expanded(
                    flex: 60,
                    child: Text(
                      'Đổi mật khẩu',
                      style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
            height: 1,
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: GestureDetector(
              onTap: () async {
            _showLogoutConfirmationDialog(context);
              },
              child: const Row(
                children: [
                  Expanded(
                    flex:15,
                    child: FaIcon(
                      FontAwesomeIcons.signOut,
                      color: AppColors.orBgr,
                      size: 30,
                    ),
                  ),
                  
                  Expanded(
                    flex: 60,
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _profile extends StatelessWidget {
  _profile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.only(
          top: AppConstant.getScreenSizeHeight(context) * 0.1,
          left: AppConstant.getScreenSizeWidth(context) * 0.02),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(ERouter.hoSo.name);
        },
        child: Row(
          children: [
            Obx(() {
              Color avatarColor;
                avatarColor = AppColors.blueVNPT;
              return Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.15,
                height: AppConstant.getScreenSizeWidth(context) * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: avatarColor,
                ),
                child: ClipOval(
                  child: Center(
                    child: Text(
                      homeController.kh.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      '${homeController.hoDem.value} ${homeController.ten.value}',
                      style: const TextStyle(
                          color: AppColors.orBgr,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                const Text(
                  'Xem hồ sơ cá nhân',
                  style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
void _showLogoutConfirmationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          CupertinoDialogAction(
  isDestructiveAction: true,
  onPressed: () async {
    final authService = Get.find<AuthService>();
    await authService.logout();
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? rememberMe = pref.getBool('rememberMe');
    if (rememberMe == null || !rememberMe) {
      await pref.remove('ma');
      await pref.remove('mk');
      await pref.remove('rememberMe');
    }
    Navigator.of(context).pop();
    Get.offAll(LoginPage());
  },
  child: Text('Đăng xuất'),
),

        ],
      );
    },
  );
}
class ChangePasswordDialog extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NSUpdateMKRepository updateMKRepository = NSUpdateMKRepository(
      provider: NSDoiMK(Get.find<AuthService>()),
    );

    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: Text('Đổi mật khẩu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu cũ',
              ),
              obscureText: true,
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu mới',
              ),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Xác nhận mật khẩu mới',
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Xác nhận'),
            onPressed: () async {
              if (newPasswordController.text != confirmPasswordController.text) {
                Get.snackbar('Lỗi', 'Mật khẩu mới và mật khẩu xác nhận không khớp', backgroundColor: AppColors.blue50);
                return;
              }
      
              // try {
                final response = await updateMKRepository.doiMK(
                  currentPass: oldPasswordController.text,
                  newPass: newPasswordController.text,
                );
                Navigator.pop(context);
      Get.snackbar('Thành công', 'Đổi mật khẩu thành công', backgroundColor: AppColors.blueVNPT);
                print('API response: $response');
      
              //   if (response['status'] == 'Success') {
              //     Navigator.of(context).pop();
              //     Get.snackbar('Thành công', 'Đổi mật khẩu thành công', backgroundColor: AppColors.blue50);
              //   } else {
              //     Get.snackbar('Lỗi', 'Đổi mật khẩu thất bại: ${response['message']}', backgroundColor: AppColors.blue50);
              //   }
              // } catch (error) {
              //   print('Change password error: $error');
              //   Get.snackbar('Lỗi', 'Đổi mật khẩu thất bại: $error', backgroundColor: AppColors.blue50);
              // }
            },
          ),
        ],
      ),
    );
  }
}