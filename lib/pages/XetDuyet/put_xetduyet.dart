import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart'; // Thêm import này để sử dụng Get.snackbar

Future<void> confirmDuyet(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ma = pref.getString('ma');

  if (ma != null) {
    final url = 'https://api.salesoft.vn/api/XetDuyet/XacNhanDuyet?Id=$id&Ma=$ma';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['message']);
      Get.snackbar(
        'Thông báo',
        'Xét duyệt thành công!',
        snackPosition: SnackPosition.TOP,
      );
    } else {
       Get.snackbar(
        'Thông báo',
        'Xét duyệt không thành công!',
        snackPosition: SnackPosition.TOP,
      );
      print('Error: ${response.statusCode}');
    }
  } else {
     Get.snackbar(
        'Thông báo',
        'Xét duyệt không thành công!',
        snackPosition: SnackPosition.TOP,
      );
    print('Không tìm thấy mã trong SharedPreferences');
  }
}

Future<void> confirmKhongDuyet(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? ma = pref.getString('ma'); 

  if (ma != null) {
    final url = 'https://api.salesoft.vn/api/XetDuyet/XacNhanHuyDuyet?Id=$id&Ma=$ma';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['message']);
      Get.snackbar(
        'Thông báo',
        'Từ chối xét duyệt thành công!',
        snackPosition: SnackPosition.TOP,
      );
    } else {
       Get.snackbar(
        'Thông báo',
        'Từ chối xét duyệt không thành công!',
        snackPosition: SnackPosition.TOP,
      );
      print('Error: ${response.statusCode}');
    }
  } else {
    Get.snackbar(
        'Thông báo',
        'Từ chối xét duyệt không thành công!',
        snackPosition: SnackPosition.TOP,
      );
    print('Không tìm thấy mã trong SharedPreferences');
  }
}
