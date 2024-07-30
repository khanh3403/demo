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
  bool isPressed = false;
  bool isLoading =false;

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
  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
   @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        isLoading = true; 
                      });

                      await getUserCurrentLocation().then((value) {
                        Get.toNamed(ERouter.chamCong.name);
                      }).catchError((error) {
                      }).whenComplete(() {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    width: AppConstant.getScreenSizeWidth(context) / 1.06,
                    height: AppConstant.getScreenSizeHeight(context) * 0.15,
                    color: AppColors.blueVNPT,
                    child: isLoading 
                        ? _buildLoadingIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: AppConstant.getScreenSizeWidth(context) * 0.05,
                              ),
                              Container(
                                width: AppConstant.getScreenSizeWidth(context) * 0.2,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Chấm công',
                                    style: TextStyle(
                                      color: AppColors.orBgr,
                                      fontSize: AppConstant.getScreenSizeWidth(context) * 0.056,
                                    ),
                                  ),
                                  Text(
                                    'để bắt đầu công việc ngay',
                                    style: TextStyle(
                                      color: AppColors.orBgr,
                                      fontSize: AppConstant.getScreenSizeWidth(context) * 0.035,
                                    ),
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
                    padding:  EdgeInsets.only(left:AppConstant.getScreenSizeWidth(context)*0.027, right: AppConstant.getScreenSizeWidth(context)*0.027),
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
                                SizedBox(
                                  height: AppConstant.getScreenSizeHeight(context) * 0.018,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                      ),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidIdCard,
                                    color: AppColors.blueVNPT2,
                                    size: AppConstant.getScreenSizeWidth(context)*0.11,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                    ),
                                    child:  Text('Hồ sơ',
                                        style: TextStyle(fontSize: AppConstant.getScreenSizeWidth(context)*0.04))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppConstant.getScreenSizeWidth(context) * 0.023,
                        ),
                         Expanded(
                          flex: 4,
                          child: AnimatedButton(
                           onTap: () {
                              Get.toNamed(ERouter.nghiPhep.name);
                            },
                            width: AppConstant.getScreenSizeWidth(context) / 2.3,
                            height:
                                AppConstant.getScreenSizeHeight(context) * 0.15,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppConstant.getScreenSizeHeight(context) * 0.018,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                      ),
                                  child: FaIcon(
                                    FontAwesomeIcons.umbrellaBeach,
                                    color: AppColors.blueVNPT2,
                                    size: AppConstant.getScreenSizeWidth(context)*0.11,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                    ),
                                    child:  Text('Đăng ký nghỉ',
                                        style: TextStyle(fontSize: AppConstant.getScreenSizeWidth(context)*0.04))),
                              ],
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
                    padding:EdgeInsets.only(left:AppConstant.getScreenSizeWidth(context)*0.027, right: AppConstant.getScreenSizeWidth(context)*0.027),
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
                                SizedBox(
                                  height: AppConstant.getScreenSizeHeight(context) * 0.018,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                      ),
                                  child: FaIcon(
                                     FontAwesomeIcons.sackDollar,
                                    color: AppColors.blueVNPT2,
                                    size: AppConstant.getScreenSizeWidth(context)*0.11,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                    ),
                                    child:  Text('Bảng lương',
                                        style: TextStyle(fontSize: AppConstant.getScreenSizeWidth(context)*0.04))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                         width: AppConstant.getScreenSizeWidth(context) * 0.023,
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
                                SizedBox(
                                  height: AppConstant.getScreenSizeHeight(context) * 0.018,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                      ),
                                   child: Image.asset(
                                    AppResource.icApproval,
                                    fit: BoxFit.fill,
                                    color: AppColors.blueVNPT2,
                                    width: AppConstant.getScreenSizeWidth(context)*0.11,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      AppConstant.getScreenSizeHeight(context) *
                                          0.022,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: AppConstant.getScreenSizeWidth(
                                              context) *
                                          0.04,
                                    ),
                                    child:  Text('Xét duyệt',
                                        style: TextStyle(fontSize: AppConstant.getScreenSizeWidth(context)*0.04))),
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
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hỗ trợ',
                                style: TextStyle(
                                    color: AppColors.orBgr, fontSize:AppConstant.getScreenSizeWidth(context) * 0.056),
                              ),
                              Text(
                                'hỗ trợ phần mềm 24/7',
                                style: TextStyle(
                                    color: AppColors.orBgr, fontSize: AppConstant.getScreenSizeWidth(context) * 0.035),
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
  _TitleAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Padding(
      padding: EdgeInsets.only(
        top: AppConstant.getScreenSizeHeight(context) * 0.07,
        left: AppConstant.getScreenSizeWidth(context) * 0.02,
      ),
      child: Row(
        children: [
          Obx(() {
            Color avatarColor = AppColors.blueVNPT;
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:  AppConstant.getScreenSizeWidth(context)*0.06,
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
              Text(
                'Xin chào!',
                style: TextStyle(color: AppColors.orBgr, fontSize: AppConstant.getScreenSizeWidth(context)*0.038,),
              ),
              Obx(() => Text(
                '${homeController.hoDem.value} ${homeController.ten.value}',
                style: TextStyle(
                  color: AppColors.orBgr,
                  fontSize: AppConstant.getScreenSizeWidth(context)*0.048,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
