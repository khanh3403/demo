// import 'package:flutter/material.dart';
// import 'package:salesoft_hrm/common/app_constant.dart';
// import 'package:salesoft_hrm/common/format_date.dart';
// import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

// class QtluongItemView extends StatelessWidget {
//   final String? soQd;
//   final String? ngayQd;
//   final String? loaiQd;
//   final String? nhanSu;
//   final String? tuNgay;
//   final String? denNgay;
//   final String? ngachCc;
//   final int? hsl;
//   final double? luongCoBan;
//   final String? noiDung;
//   final String? soHd;
//   final String? hdld;
//   final String? phuLucHopDong;
//   final String? pcTrachNhiem;
//   final String? pcLuong;
//   final String? pcKhac;
//   final String? bhxh;
//   final String? lanKy;
//   final String? ghiChu;

 
//   const QtluongItemView(
//       {Key? key,
//       this.hoTen,
//       this.quanHe,
//       this.ngaySinh,
//       this.diaChi,
//       this.ngheNghiep,
//       this.maSoThue,
//       this.soCmt,
//       this.ngayCmt,
//       this.noiCmt,
//       this.ghiChu})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: AppConstant.getScreenSizeWidth(context) * 0.03,
//         ),
//         Container(
//           width: AppConstant.getScreenSizeWidth(context) * 0.9,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 )
//               ]),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Họ tên', text2: hoTen ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Quan hệ', text2: quanHe ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Ngày sinh', text2: formatDate(ngaySinh) ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Địa chỉ', text2: diaChi ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Nghề nghiệp', text2: ngheNghiep ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Mã số thuế', text2: maSoThue ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'CCCD/CMND', text2: soCmt ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Ngày cấp', text2: formatDate(ngayCmt) ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Nơi cấp', text2: noiCmt ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//               RowHoSo(text1: 'Ghi chú', text2: ghiChu ?? ''),
//               SizedBox(
//                 height: AppConstant.getScreenSizeHeight(context) * 0.01,
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
