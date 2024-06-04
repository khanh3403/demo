import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.orBgr,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TitleAppBarWidget(),
          ),
          Positioned(
            top: AppConstant.getScreenSizeHeight(context) / 4.7,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedButton(
                  onTap: () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.location,
                      Permission.locationWhenInUse,
                    ].request();

                    if (statuses.values.every(
                        (status) => status == PermissionStatus.granted)) {
                      Get.toNamed(ERouter.chamCong.name);
                    } else if (statuses.values
                        .every((status) => status == PermissionStatus.denied)) {
                      showToast("Bạn cần cấp quyền vị trí cho ứng dụng này");
                    }
                  },
                  width: AppConstant.getScreenSizeWidth(context) / 1.06,
                  height: AppConstant.getScreenSizeHeight(context) * 0.15,
                  color: AppColors.terraCotta,
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
                              Image.asset(
                                AppResource.icBangLuong,
                                fit: BoxFit.cover,
                                width: AppConstant.getScreenSizeWidth(context) *
                                    0.15,
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Hồ sơ',
                                      style: TextStyle(fontSize: 20))),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Thông tin cá nhân',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100))),
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
                                Image.asset(
                                  AppResource.icNghiLe,
                                  fit: BoxFit.cover,
                                  width:
                                      AppConstant.getScreenSizeWidth(context) *
                                          0.15,
                                ),
                                const Text('Nghỉ phép',
                                    style: TextStyle(fontSize: 20)),
                                const Text('Nghỉ ngày/Nghỉ ca',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100))
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
                            // Get.toNamed(ERouter.hoSo.name);
                          },
                          width: AppConstant.getScreenSizeWidth(context) / 2.3,
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.15,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppResource.icBangLuong,
                                fit: BoxFit.cover,
                                width: AppConstant.getScreenSizeWidth(context) *
                                    0.15,
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Bảng lương',
                                      style: TextStyle(fontSize: 20))),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('1/5/2024-1/6/2024',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100))),
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
                            Get.toNamed(ERouter.hoSo.name);
                          },
                          width: AppConstant.getScreenSizeWidth(context) / 2.3,
                          height:
                              AppConstant.getScreenSizeHeight(context) * 0.15,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppResource.icBangLuong,
                                fit: BoxFit.cover,
                                width: AppConstant.getScreenSizeWidth(context) *
                                    0.15,
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Xét duyệt',
                                      style: TextStyle(fontSize: 20))),
                              const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Xét duyệt công việc',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w100))),
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
                  onTap: () async {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.location,
                      Permission.locationWhenInUse,
                    ].request();

                    if (statuses.values.every(
                        (status) => status == PermissionStatus.granted)) {
                      Get.toNamed(ERouter.chamCong.name);
                    } else if (statuses.values
                        .every((status) => status == PermissionStatus.denied)) {
                      showToast("Bạn cần cấp quyền vị trí cho ứng dụng này");
                    }
                  },
                  width: AppConstant.getScreenSizeWidth(context) / 1.06,
                  height: AppConstant.getScreenSizeHeight(context) * 0.15,
                  color: AppColors.blue,
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Transform.scale(
                              scale: 0.7,
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
        Image.asset(
          AppResource.icbannervnpt,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height / 3.5,
        ),
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
                  if (homeController.gioiTinh.value == "Nam") {
                    avatarColor = Colors.blue;
                  } else {
                    avatarColor = Colors.pink;
                  }

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
                              color: AppColors.orBgr, fontSize: 18),
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
