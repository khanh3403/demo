import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/app_global.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/Home/home_animated.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/widgets/function_item_widget.dart';
import '../../resources/app_resource.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  bool isPressed = false;

  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog();
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
    void _showPermissionDeniedDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Image.asset(AppResource.icWarning, height: 80,
                width: 80,),
          content: Text('Bạn cần cấp quyền truy cập vị trí để sử dụng tính năng này.'),
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
Future<bool> _onWillPop() async {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có muốn thoát không?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Không'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text('Có'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    ) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TitleAppBarWidget(),
            ),
            Positioned(
              top: AppConstant.getScreenSizeHeight(context) / 5.6,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedButton(
                    onTap: () async {
                      getUserCurrentLocation().then((value)async{
                        Get.toNamed(ERouter.chamCong.name);
                      });
                    },
                    width: AppConstant.getScreenSizeWidth(context) / 1.06,
                    height: AppConstant.getScreenSizeHeight(context) * 0.15,
                    color: AppColors.blueVNPT,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppConstant.getScreenSizeWidth(context) * 0.05,
                        ),
                        Container(
                          width: AppConstant.getScreenSizeWidth(context) * 0.2,
                          height: AppConstant.getScreenSizeWidth(context) * 0.2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Transform.scale(
                              scale: 0.7,
                              child: Image.asset(
                                AppResource.icTap,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppConstant.getScreenSizeWidth(context) * 0.03,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chấm công',
                              style:
                                  TextStyle(color: AppColors.orBgr, fontSize: 24),
                            ),
                            Text(
                              'để bắt đầu công việc ngay',
                              style:
                                  TextStyle(color: AppColors.orBgr, fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: AnimatedButton(
                            onTap: () {
                              Get.toNamed(ERouter.hoSo.name);
                            },
                            width: AppConstant.getScreenSizeWidth(context) / 2.3,
                            height:
                                AppConstant.getScreenSizeHeight(context) * 0.15,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeHeight(
                                              context) *
                                          0.022,
                                      top: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.0003),
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidIdCard,
                                    color: AppColors.blueVNPT2,
                                    size: 50,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeHeight(
                                              context) *
                                          0.022,
                                    ),
                                    child: const Text('Hồ sơ',
                                        style: TextStyle(fontSize: 20))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppConstant.getScreenSizeHeight(context) * 0.01,
                        ),
                        Expanded(
                          flex: 4,
                          child: AnimatedButton(
                            onTap: () {
                              // Get.toNamed(ERouter.hoSo.name);
                            },
                            width: AppConstant.getScreenSizeWidth(context) / 2.3,
                            height:
                                AppConstant.getScreenSizeHeight(context) * 0.15,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: AppConstant.getScreenSizeHeight(
                                                context) *
                                            0.014,
                                        top: AppConstant.getScreenSizeWidth(
                                                context) *
                                            0.02),
                                    
                                    child: const FaIcon(
                                      FontAwesomeIcons.umbrellaBeach,
                                      color: AppColors.blueVNPT2,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        AppConstant.getScreenSizeHeight(context) *
                                            0.018,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(       
                                        left: AppConstant.getScreenSizeHeight(
                                                context) *
                                            0.01,
                                      ),
                                      child: const Text('Đăng ký nghỉ',
                                          style: TextStyle(fontSize: 20))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: AnimatedButton(
                            onTap: () {
                            },
                            width: AppConstant.getScreenSizeWidth(context) / 2.3,
                            height:
                                AppConstant.getScreenSizeHeight(context) * 0.15,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        AppConstant.getScreenSizeHeight(context) *
                                            0.02,
                                    top: AppConstant.getScreenSizeWidth(context) *
                                        0.03,
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.sackDollar,
                                    color: AppColors.blueVNPT2,
                                    size: 50,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeHeight(
                                              context) *
                                          0.022,
                                    ),
                                    child: const Text('Bảng lương',
                                        style: TextStyle(fontSize: 20))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppConstant.getScreenSizeHeight(context) * 0.01,
                        ),
                        Expanded(
                          flex: 4,
                          child: AnimatedButton(
                            onTap: () {
                              Get.toNamed(ERouter.xetduyet.name);
                            },
                            width: AppConstant.getScreenSizeWidth(context) / 2.3,
                            height:
                                AppConstant.getScreenSizeHeight(context) * 0.15,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeHeight(
                                              context) *
                                          0.03,
                                      top: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.025),
                                  child: Image.asset(
                                    AppResource.icApproval,
                                    fit: BoxFit.fill,
                                    color: AppColors.blueVNPT2,
                                    width:
                                        AppConstant.getScreenSizeWidth(context) *
                                            0.12,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.02,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeHeight(
                                              context) *
                                          0.022,
                                    ),
                                    child: const Text('Xét duyệt',
                                        style: TextStyle(fontSize: 20))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.03,
                  ),
                  AnimatedButton(
                    onTap: () {},
                    width: AppConstant.getScreenSizeWidth(context) / 1.06,
                    height: AppConstant.getScreenSizeHeight(context) * 0.15,
                    color: AppColors.blueVNPT,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppConstant.getScreenSizeWidth(context) * 0.05,
                          ),
                          Container(
                            width: AppConstant.getScreenSizeWidth(context) * 0.2,
                            height: AppConstant.getScreenSizeWidth(context) * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        AppConstant.getScreenSizeWidth(context) *
                                            0.07,
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.info,
                                    color: AppColors.blueVNPT2,
                                    size: 80,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppConstant.getScreenSizeWidth(context) * 0.03,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hỗ trợ',
                                style: TextStyle(
                                    color: AppColors.orBgr, fontSize: 24),
                              ),
                              Text(
                                'hỗ trợ phần mềm 24/7',
                                style: TextStyle(
                                    color: AppColors.orBgr, fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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

class _TitleAppBarWidget extends StatelessWidget {
  _TitleAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: AppConstant.getScreenSizeHeight(context) * 0.07,
              left: AppConstant.getScreenSizeWidth(context) * 0.02),
          child: Positioned(
            bottom: 130,
            left: 20,
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
                    const Text(
                      'Xin chào!',
                      style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                    ),
                    Obx(() => Text(
                          '${homeController.hoDem.value} ${homeController.ten.value}',
                          style: const TextStyle(
                              color: AppColors.orBgr,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
