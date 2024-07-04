import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/app_global.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/UnApproved/not_approved_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/UnApproved/not_approved_item.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class MyInformation extends StatelessWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final HocVanController controller = Get.put(HocVanController());
    bool isValidPhoneNumber(String phone) {
  final RegExp phoneExp = RegExp(r'^0[0-9]{9}$');
  return phoneExp.hasMatch(phone);
}

bool isValidEmail(String email) {
  final RegExp emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return emailExp.hasMatch(email);
}

void dialogApproved() {
       final NotApprovedController approvedController=Get.put(NotApprovedController());


  approvedController.fetchListContent();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Đang chờ xét duyệt'),
        content: Container(
          width: double.maxFinite,
          child: Get.find<NotApprovedController>().obx(
            (state) {
              if (state == null || state.isEmpty) {
                return const Center(
                  child: Text('Không có thông tin'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final item = state[index];
                  return ApprovedItemView(
                    cotDuLieu: item.cotDuLieu,
                    duLieu: item.duLieu,
                  );
                },
              );
            },
            onLoading: const Center(child: CircularProgressIndicator()),
            onError: (error) => Center(child: Text('Lỗi: $error')),
          ),
        ),
        actions: [
          
        ],
      );
    },
  );
}


    void _showEditDialog(String title, String currentValue, String cot) {
  final TextEditingController textController = TextEditingController(text: currentValue);
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thay đổi $title'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Nhập $title mới',
            ),
            keyboardType: (title == 'điện thoại') ? TextInputType.phone : TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập $title';
              }
              if (title == 'điện thoại' && !isValidPhoneNumber(value)) {
                return 'Số điện thoại không hợp lệ';
              }
              if (title == 'email' && !isValidEmail(value)) {
                return 'Email không hợp lệ';
              }
              return null;
            },
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String newValue = textController.text;
                await homeController.updateUserInfo(cot, newValue);
                showToast("Đăng ký thay đổi $title thành công");
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}


    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: AppColors.blueVNPT,
        centerTitle: false,
        elevation: 0,
        title: const TitleAppBarWidget(title: "Sơ Yếu Lý Lịch"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: AppConstant.getScreenSizeWidth(context) * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Row(
              children:[
                  const Text(
                'Thông tin cá nhân',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: AppConstant.getScreenSizeWidth(context)*0.05,),
              GestureDetector(
                onTap:() {
                  dialogApproved();
                },
                child: const FaIcon(FontAwesomeIcons.list)),
              ]
             ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Họ tên',
                      text2:
                          '${homeController.hoDem.value} ${homeController.ten.value}',
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Ngày sinh',
                      text2: formatDate(homeController.ngaySinh.value),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Giới tính',
                      text2: homeController.gioiTinh.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Địa chỉ',
                      icon: Icons.edit,
                      text2: homeController.dcll.value,
                      onTap: () => _showEditDialog('địa chỉ','', 'DCLL'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Điện thoại',
                      icon: Icons.edit,
                      text2: homeController.dienThoai.value,
                      onTap: () => _showEditDialog('điện thoại','', 'DienThoai'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      icon: Icons.edit,
                      text1: 'Email',
                      text2: homeController.email.value,
                      onTap: () => _showEditDialog('email','', 'Email'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                      RowHoSo(
                      text1: 'Số CMT',
                      text2: homeController.cmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                      RowHoSo(
                      text1: 'Nơi cấp',
                      text2: homeController.noiCmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                      RowHoSo(
                      text1: 'Ngày cấp',
                      text2: formatDate(homeController.ngayCmt.value),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      icon: Icons.edit,
                      text1: 'Tài khoản',
                      text2: homeController.taiKhoan.value,
                      onTap: () => _showEditDialog('tài khoản','', 'TaiKhoan'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      icon: Icons.edit,
                      text1: 'Ngân hàng',
                      text2: homeController.nganHang.value,
                      onTap: () => _showEditDialog('ngân hàng','', 'NganHang'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Đơn vị',
                      text2: homeController.donVi.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Phòng ban',
                      text2: homeController.phongBan.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Bộ phận',
                      text2: homeController.toCongTac.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Chức vụ',
                      text2: homeController.chucVu.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.07,
              ),
              const Text(
                'Học vấn',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.01,
              ),
              Container(
                child: Get.find<HocVanController>().obx(
                  (state) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: state?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = state!.data![index];
                      return HocVanItemView(
                        nhanSu: item.nhanSu,
                        hocVan: item.hocVan,
                        hocVi: item.hocVi,
                        truongDt: item.truongDt,
                        loaiBang: item.loaiBang,
                        chuyenNganh: item.chuyenNganh,
                        namTn: item.namTn,
                        quocGia: item.quocGia,
                      );
                    },
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: const Center(
                    child: Text('Không có thông tin'),
                  ),
                  onError: (error) => const Center(child: Text('Không có thông tin')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class RowHoSo3 extends StatefulWidget {
  final String text1;
  final String text2;
  final IconData icon;
  final Function()? onTap; 

  const RowHoSo3({Key? key, required this.text1, required this.text2,required this.icon, this.onTap})
      : super(key: key);

  @override
  _RowHoSoState createState() => _RowHoSoState();
}

class _RowHoSoState extends State<RowHoSo3> {
  bool thuGon = true;
  bool xemThem = false;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppConstant.getScreenSizeWidth(context) * 0.05,
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: widget.onTap, 
            child: Row(
              children: [Text(
                widget.text1,
                style: TextStyle(fontSize: 18,),
              ),
              SizedBox(width: AppConstant.getScreenSizeWidth(context)*0.01,),
              Column(
                children:[
                   Icon(
                widget.icon,
                size:15,

              ),
              SizedBox(height: AppConstant.getScreenSizeHeight(context)*0.015),
                ]
              )
              ]
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              setState(() {
                thuGon = !thuGon;
                xemThem = !xemThem;
              });
            },
            child: Text(
              widget.text2,
              maxLines: xemThem ? (thuGon ? 1 : 3) : 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
