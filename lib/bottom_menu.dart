import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_page.dart';
import 'package:salesoft_hrm/pages/Home/home_page.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
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
          appBar: controller.pageIndex.value == 0
              ? null
              : AppBar(
                  title: _TitleAppBarWidget2(controller: controller),
                  toolbarHeight: 60,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  elevation: 0,
                  leading: Container(),
                ),
          body: Stack(
            children: [
              _getPage(controller.pageIndex.value),
            ],
          ),
          bottomNavigationBar: NavigationBar(
              height: AppConstant.getScreenSizeHeight(context) * 0.07,
              elevation: 0,
              selectedIndex: controller.pageIndex.value,
              onDestinationSelected: (index) =>
                  controller.pageIndex.value = index,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.contacts), label: 'Danh bạ'),
                NavigationDestination(
                    icon: Icon(Icons.notifications), label: 'Thông báo'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Tài khoản'),
              ]),
        );
      }),
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
        return Center(child: Text('Xét Duyệt Page'));
      default:
        return Center(child: Text('Unknown Page'));
    }
  }
}

class _TitleAppBarWidget2 extends StatelessWidget {
  final MainController controller;
  final GlobalKey _iconKey = GlobalKey();

  _TitleAppBarWidget2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LeadingTitleView(),
        SizedBox(
          width: AppConstant.getScreenSizeWidth(context) * 0.3,
        ),
        _CircleIconWidget(
          key: _iconKey,
          imageAssetName: AppResource.icMenu,
          onPress: () {
            final RenderBox renderBox =
                _iconKey.currentContext!.findRenderObject() as RenderBox;
            final position = renderBox.localToGlobal(Offset.zero);
            _showCustomDialog(context, position, renderBox.size);
          },
        ),
      ],
    );
  }
}

class _LeadingTitleView extends StatelessWidget {
  const _LeadingTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppResource.icLogoVNPT,
    );
  }
}

class _CircleIconWidget extends StatelessWidget {
  final String imageAssetName;
  final Function()? onPress;

  const _CircleIconWidget({
    Key? key,
    required this.imageAssetName,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: onPress,
      padding: const EdgeInsets.all(4),
      borderRadius: 22,
      child: Image.asset(
        imageAssetName,
        fit: BoxFit.fill,
        width: 28,
        height: 28,
      ),
    );
  }
}

void _showCustomDialog(BuildContext context, Offset position, Size iconSize) {
  OverlayState? overlayState = Overlay.of(context);
  if (overlayState == null) {
    return;
  }

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        overlayEntry.remove();
      },
      child: Stack(
        children: [
          Positioned(
            left: position.dx + iconSize.width - 200,
            top: position.dy + iconSize.height,
            child: Material(
              elevation: 4.0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 200,
                child: InkWell(
                  onTap: () {
                    _logout(context);
                    overlayEntry.remove();
                  },
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 7,
                        child: Text(
                          'Đăng xuất',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  overlayState.insert(overlayEntry);
}

void _logout(BuildContext context) {
  Get.offAll(LoginPage());
}
