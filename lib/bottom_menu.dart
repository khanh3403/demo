import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_page.dart';
import 'package:salesoft_hrm/pages/Home/home_page.dart';
import 'package:salesoft_hrm/pages/TaiKhoan/taikhoan_page.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<IDanhBaProvider>(
      () => DanhBaProviderAPI(),
      fenix: true,
    );
    Get.lazyPut<IDanhBaRepository>(
      () => DanhBaRepository(provider: Get.find()),
      fenix: true,
    );

    return SafeArea(
      top: false,
      bottom: false,
      child: Obx(() {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppResource.icBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                _getPage(controller.pageIndex.value),
              ],
            ),
          ),
          bottomNavigationBar: controller.obx((state) {
            return _bottomAppBarView(controller);
          }),
        );
      }),
    );
  }

  BottomAppBar _bottomAppBarView(MainController controller) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.greyBackground,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppConstant.kSpaceHorizontalMedium,
          right: AppConstant.kSpaceHorizontalMedium,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _NavigationItemView(
              canShowBadge: false,
              label: 'Trang chủ',
              assetName: AppResource.icHome,
              assetColor: AppColors.grey,
              index: 0,
              onPress: () => controller.pageIndex.value = 0,
            ),
            _NavigationItemView(
              canShowBadge: false,
              label: 'Danh bạ',
              index: 1,
              assetName: AppResource.icPlay,
              onPress: () => controller.pageIndex.value = 1,
            ),
            controller.obx((state) {
              return _NavigationItemView(
                canShowBadge: true,
                label: 'Thông báo',
                index: 2,
                badgeContent: controller.listNotificationUnread.length,
                assetName: AppResource.icNotification,
                onPress: () async {
                  controller.pageIndex.value = 2;
                },
              );
            }),
            _NavigationItemView(
              canShowBadge: false,
              label: 'Tài khoản',
              index: 3,
              assetName: AppResource.icUser,
              onPress: () => controller.pageIndex.value = 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return HomePage();
      case 1:
        return DanhBaPage();
      case 2:
        return Center(child: Text('Notification Page'));
      case 3:
        return TaiKhoanPage();
      default:
        return Center(child: Text('Unknown Page'));
    }
  }
}

class _NavigationItemView extends StatelessWidget {
  final Function()? onPress;
  final String? assetName;
  final IconData? icon;
  final Color? assetColor;
  final String? label;
  final int? index;
  final bool? canShowBadge;
  final int badgeContent;

  const _NavigationItemView({
    Key? key,
    this.onPress,
    this.assetName,
    this.icon,
    this.label,
    this.assetColor,
    this.index = -1,
    this.canShowBadge,
    this.badgeContent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    return Expanded(
      child: InkWellWidget(
        borderRadius: 4,
        padding: EdgeInsets.only(
          top: 4,
        ),
        onPress: onPress,
        child: SizedBox(
          height: ScreenUtil().bottomBarHeight > 0 ? 40.h : 60.h,
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    _buildIcon(controller),
                    Visibility(
                      visible: (canShowBadge == true) && badgeContent != 0,
                      child: Positioned(
                        right: 0,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 16.r,
                            minHeight: 16.r,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Center(
                            child: Text(
                              badgeContent.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AppConstant.spaceVerticalSmall,
                Text(
                  label ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        color: controller.pageIndex.value == index
                            ? AppColors.blue
                            : AppColors.grey300,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(MainController controller) {
    if (assetName?.isNotEmpty == true) {
      //  if (icon == true) {
      return Container(
        alignment: Alignment.center,
        width: 24.r,
        height: 24.r,
        child: Image.asset(
          assetName ?? '',
          width: 20.r,
          height: 20.r,
          fit: BoxFit.fill,
          color: controller.pageIndex.value == index
              ? AppColors.blueVNPT2
              : AppColors.grey,
        ),
      );
    } else {
      return SizedBox(
        width: 20.r,
        height: 20.r,
      );
    }
  }
}
