// import 'package:flutter/material.dart';
// import 'package:salesoft_hrm/common/app_constant.dart';
// import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

// class ApprovedItemView extends StatelessWidget {
//   final String? hoTen;
//   final String? ngaySinh;
//   final String? noiSinh;
//   final String? gioiTinh;
//   final String? diaChi;
//   final String? dienThoai;
//   final String? email;
//   final String? soCmt;
//   final String? noiCap;
//   final String? ngayCap;
//   final String? taiKhoan;
//   final String? nganHang;


//   const ApprovedItemView({
//     Key? key,
//     this.hoTen,
//     this.ngaySinh,
//     this.noiSinh,
//     this.gioiTinh,
//     this.diaChi,
//     this.dienThoai,
//     this.email,
//     this.soCmt,
//     this.noiCap,
//     this.ngayCap,
//     this.taiKhoan,
//     this.nganHang,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: AppConstant.getScreenSizeWidth(context) * 0.03,
//         ),
//               RowHoSo(text1: 'Họ tên', text2: hoTen ?? ''),
//               RowHoSo(text1: 'Ngày sinh', text2: ngaySinh ?? ''),
//               RowHoSo(text1: 'Nơi sinh', text2: noiSinh ?? ''),
//               RowHoSo(text1: 'Giới tính', text2: gioiTinh ?? ''),
//               RowHoSo(text1: 'Điện thoại', text2: dienThoai ?? ''),
//               RowHoSo(text1: 'Email', text2: email ?? ''),
//               RowHoSo(text1: 'CCCD/CMND', text2: soCmt ?? ''),
//               RowHoSo(text1: 'Nơi cấp', text2: noiCap ?? ''),
//               RowHoSo(text1: 'Ngày cấp', text2: ngayCap ?? ''),
//               RowHoSo(text1: 'Tài khoản', text2: taiKhoan ?? ''),
//               RowHoSo(text1: 'Ngân hàng', text2: nganHang ?? ''),
//       ],
//     );
//   }
// }
