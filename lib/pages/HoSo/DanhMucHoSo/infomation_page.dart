import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/NS_Update_provider.dart';
import 'package:salesoft_hrm/API/repository/NS_Update_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/UnApproved/not_approved_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/UnApproved/not_approved_item.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
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
    final ApprovedController approvedController = Get.put(ApprovedController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đang chờ xét duyệt'),
          content: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Họ tên',
                      text2: '${homeController.hoDem.value} ${homeController.ten.value}',
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Ngày sinh',
                      text2: formatDate(approvedController.ngaySinh.value),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Giới tính',
                      text2: approvedController.gioiTinh.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Địa chỉ',
                      text2: approvedController.dcll.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Điện thoại',
                      // icon: Icons.edit,
                      text2: approvedController.dienThoai.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Email',
                      text2: approvedController.email.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Số CMT',
                      text2: approvedController.cmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Nơi cấp',
                      text2: approvedController.noiCmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Ngày cấp',
                      text2: formatDate(approvedController.ngayCmt.value),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Tài khoản',
                      text2: approvedController.taiKhoan.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Ngân hàng',
                      text2: approvedController.nganHang.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
          actions: [],
        );
      },
    );
  }
void _showEditDialog2() {
  final AuthService authService = Get.find<AuthService>();
  final TextEditingController hoTenController = TextEditingController(text: '${homeController.hoDem.value} ${homeController.ten.value}');
  final TextEditingController ngaySinhController = TextEditingController(text: formatDate(homeController.ngaySinh.value));
  final TextEditingController diaChiController = TextEditingController(text: homeController.dcll.value);
  final TextEditingController dienThoaiController = TextEditingController(text: homeController.dienThoai.value);
  final TextEditingController emailController = TextEditingController(text: homeController.email.value);
  final TextEditingController cmtController = TextEditingController(text: homeController.cmt.value);
  final TextEditingController noiCapController = TextEditingController(text: homeController.noiCmt.value);
  final TextEditingController ngayCapController = TextEditingController(text: formatDate(homeController.ngayCmt.value));
  final TextEditingController taiKhoanController = TextEditingController(text: homeController.taiKhoan.value);
  final TextEditingController nganHangController = TextEditingController(text: homeController.nganHang.value);
  final TextEditingController noiSinhController = TextEditingController();
  final TextEditingController dcttController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String gioiTinh = homeController.gioiTinh.value;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              children: [
                Text('Chỉnh sửa thông tin'),
                GestureDetector(
                  onTap: () {
                    dialogApproved();
                  },
                  child: const FaIcon(FontAwesomeIcons.list),
                ),
              ],
            ),
            content: Container(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: hoTenController,
                        decoration:const InputDecoration(
                          labelText: 'Họ tên',
                          
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập họ tên';
                          }
                          return null;
                        },
                        enabled: false, 
                      ),
                      TextFormField(
                        controller: ngaySinhController,
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              ngaySinhController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập ngày sinh';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: noiSinhController,
                        decoration: InputDecoration(
                          labelText: 'Nơi sinh',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              noiSinhController.clear();
                            },
                          ),
                        ),
                        
                      ),
                      Row(
                        children: [
                          Text('Giới tính:', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            value: gioiTinh,
                            onChanged: (String? newValue) {
                              setState(() {
                                gioiTinh = newValue!;
                                homeController.gioiTinh.value = gioiTinh;
                              });
                            },
                            items: <String>['Nam', 'Nữ']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                       TextFormField(
                        controller: dcttController,
                        decoration: InputDecoration(
                          labelText: 'Địa chỉ thường chú',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              dcttController.clear();
                            },
                          ),
                        ),
                      
                      ),
                      TextFormField(
                        controller: diaChiController,
                        decoration: InputDecoration(
                          labelText: 'Địa chỉ liên lạc',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              diaChiController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập địa chỉ';
                          }
                          return null;
                        },
                      ),
                      
                      TextFormField(
                        controller: dienThoaiController,
                        decoration: InputDecoration(
                          labelText: 'Điện thoại',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              dienThoaiController.clear();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (!isValidPhoneNumber(value)) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              emailController.clear();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          if (!isValidEmail(value)) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cmtController,
                        decoration: InputDecoration(
                          labelText: 'Số CMT',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              cmtController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số CMT';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: noiCapController,
                        decoration: InputDecoration(
                          labelText: 'Nơi cấp',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              noiCapController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập nơi cấp';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: ngayCapController,
                        decoration: InputDecoration(
                          labelText: 'Ngày cấp',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              ngayCapController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập ngày cấp';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: taiKhoanController,
                        decoration: InputDecoration(
                          labelText: 'Tài khoản',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              taiKhoanController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tài khoản';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: nganHangController,
                        decoration: InputDecoration(
                          labelText: 'Ngân hàng',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              nganHangController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập ngân hàng';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final provider2 = NSUpdateAPI2(authService);
                      final repository2 = NSUpdateNSRepository(provider2: provider2);
                      final DateFormat formatter = DateFormat('yyyy/MM/dd');
                      final String formattedNgaySinh = formatter.format(DateFormat('dd/MM/yyyy').parse(ngaySinhController.text));
                      final String formattedNgayCap = formatter.format(DateFormat('dd/MM/yyyy').parse(ngayCapController.text));
                      await repository2.NSUpdateAPI2(
                        ngaySinh: formattedNgaySinh,
                        dienThoai: dienThoaiController.text,
                        dcll: diaChiController.text,
                        email: emailController.text,
                        cmt: cmtController.text,
                        noiCmt: noiCapController.text,
                        ngayCmt: formattedNgayCap,
                        nganHang: nganHangController.text,
                        taiKhoan: taiKhoanController.text,
                        noiSinh: noiSinhController.text,
                        gioiTinh: gioiTinh,
                        dctt: dcttController.text,
                      );

                      Get.snackbar("Thông báo", "Cập nhật thông tin cá nhân thành công",
                          snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
                      Navigator.of(context).pop();
                    } catch (error) {
                      Get.snackbar("Lỗi", "Cập nhật thông tin cá nhân thất bại: $error",
                          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
                    }
                  }
                },
              ),
            ],
          );
        },
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
            child: Stack(
              children: [
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: currentValue,
                    suffixIcon: textController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                textController.clear();
                              });
                            },
                          )
                        : null,
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
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
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
                  Get.snackbar("Thông báo", "Đăng ký thay đổi $title thành công", snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.only(left: AppConstant.getScreenSizeWidth(context) * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.03,
              ),
              Row(
                children: [
                  const Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: AppConstant.getScreenSizeWidth(context) * 0.05),
                  GestureDetector(
                    onTap: () {
                      // dialogApproved();
                     _showEditDialog2();
                    },
                    child: const FaIcon(FontAwesomeIcons.edit),
                    // child: Text('Xét duyệt'),
                  ),
                ],
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
                      text2: '${homeController.hoDem.value} ${homeController.ten.value}',
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
                      // icon: Icons.edit,
                      text2: homeController.dcll.value,
                      onTap: () => _showEditDialog('địa chỉ', homeController.dcll.value, 'DCLL'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Điện thoại',
                      // icon: Icons.edit,
                      text2: homeController.dienThoai.value,
                      onTap: () => _showEditDialog('điện thoại', homeController.dienThoai.value, 'DienThoai'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Email',
                      text2: homeController.email.value,
                      onTap: () => _showEditDialog('email', homeController.email.value, 'Email'),
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
                      // icon: Icons.edit,
                      text1: 'Tài khoản',
                      text2: homeController.taiKhoan.value,
                      onTap: () => _showEditDialog('tài khoản', homeController.taiKhoan.value, 'TaiKhoan'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Ngân hàng',
                      text2: homeController.nganHang.value,
                      onTap: () => _showEditDialog('ngân hàng',homeController.nganHang.value, 'NganHang'),
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
  // final IconData icon;
  final Function()? onTap; 

  const RowHoSo3({Key? key, required this.text1, required this.text2,
  // required this.icon, 
  this.onTap})
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
              // Column(
              //   children:[
              //      Icon(
              //   widget.icon,
              //   size:15,

              // ),
              // SizedBox(height: AppConstant.getScreenSizeHeight(context)*0.015),
              //   ]
              // )
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
