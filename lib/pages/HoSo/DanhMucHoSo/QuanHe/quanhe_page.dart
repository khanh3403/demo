import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/repository/post_quanHe_repository.dart';
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
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: Row(
          children: [
            TitleAppBarWidget(title: "Quan hệ gia đình"),
            SizedBox(width:AppConstant.getScreenSizeWidth(context)*0.2),
            GestureDetector(
                    onTap: () {
                      _showAddInfoDialog(context);
                    },
                    child: const FaIcon(FontAwesomeIcons.personCirclePlus,color:AppColors.approved),
                  ),
          ],
        ),
      ),
      body: controller.obx(
        (state) => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstant.getScreenSizeWidth(context) * 0.05,
            vertical: 10,
          ),
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
    );
  }
}
void _showAddInfoDialog(BuildContext context) {
  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController quanHeController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  final TextEditingController ngheNghiepController = TextEditingController();
  final TextEditingController maSoThueController = TextEditingController();
  final TextEditingController soCmtController = TextEditingController();
  final TextEditingController ngayCmtController = TextEditingController();
  final TextEditingController noiCmtController = TextEditingController();
  final TextEditingController ghiChuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thêm thông tin mới'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: hoTenController,
                  decoration: InputDecoration(labelText: 'Họ tên'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ tên';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quanHeController,
                  decoration: InputDecoration(labelText: 'Quan hệ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập quan hệ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ngaySinhController,
                  decoration: InputDecoration(labelText: 'Ngày sinh'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ngày sinh';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: diaChiController,
                  decoration: InputDecoration(labelText: 'Địa chỉ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ngheNghiepController,
                  decoration: InputDecoration(labelText: 'Nghề nghiệp'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nghề nghiệp';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: maSoThueController,
                  decoration: InputDecoration(labelText: 'Mã số thuế'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã số thuế';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: soCmtController,
                  decoration: InputDecoration(labelText: 'CCCD/CMND'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số CCCD/CMND';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ngayCmtController,
                  decoration: InputDecoration(labelText: 'Ngày cấp'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ngày cấp';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: noiCmtController,
                  decoration: InputDecoration(labelText: 'Nơi cấp'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nơi cấp';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ghiChuController,
                  decoration: InputDecoration(labelText: 'Ghi chú'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập ghi chú';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Xác nhận'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final data = {
                  'hoTen': hoTenController.text,
                  'quanHe': quanHeController.text,
                  'ngaySinh': ngaySinhController.text,
                  'diaChi': diaChiController.text,
                  'ngheNghiep': ngheNghiepController.text,
                  'maSoThue': maSoThueController.text,
                  'soCmt': soCmtController.text,
                  'ngayCmt': ngayCmtController.text,
                  'noiCmt': noiCmtController.text,
                  'ghiChu': ghiChuController.text,
                };

                postNewInfo(data).then((_) {
                  Navigator.of(context).pop();
                }).catchError((error) {
                  print('Lỗi khi gửi yêu cầu: $error');
                });
              }
            },
          ),
        ],
      );
    },
  );
}
