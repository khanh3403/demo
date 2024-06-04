import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/hoso_body.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/widgets/appbar_container_widget.dart';

class HoSoPage extends StatelessWidget {
  const HoSoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Stack(
      children: [
        const AppBarContainerWidget(
          title: Text(
            'Hồ Sơ',
            style: TextStyle(color: Colors.white),
          ),
          body: HoSoBody(),
        ),
        Positioned(
          top: AppConstant.getScreenSizeHeight(context) / 8,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: 120,
                child: Card(
                  elevation: 6,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                            width:
                                AppConstant.getScreenSizeWidth(context) * 0.2,
                            height:
                                AppConstant.getScreenSizeWidth(context) * 0.2,
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
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    '${homeController.hoDem.value} ${homeController.ten.value}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      height: 1.5,
                                    ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Chức vụ: ${homeController.chucVu.value} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                              AppConstant.spaceVerticalSmallExtra,
                              Obx(() => Text(
                                    'Phòng: ${homeController.phongBan.value} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.5,
                                        ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
//
      ],
    );
  }
}
