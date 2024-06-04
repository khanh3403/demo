import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class QuanHePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuanHeController controller = Get.put(QuanHeController());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blue,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Quan hệ gia đình"),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: AppConstant.getScreenSizeWidth(context) * 0.05),
        child: controller.obx(
          (state) => ListView.builder(
            itemCount: state?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final item = state!.data![index];
              return QuanHeItemView(
                hoTen: item.hoTen,
                quanHe: item.quanHe,
                ngaySinh: item.ngaySinh,
                diaChi: item.diaChi,
                ngheNghiep: item.ngheNghiep,
                maSoThue: item.maSoThue,
                soCmt: item.soCmt,
                ngayCmt: item.ngayCmt,
                noiCmt: item.noiCmt,
                ghiChu: item.ghiChu,
              );
            },
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Center(
            child: Text('Không có thông tin quan hệ'),
          ),
          onError: (error) => Center(child: Text('Lỗi: $error')),
        ),
      ),
    );
  }
}
