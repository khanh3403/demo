import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  static const String baseUrl = 'https://api.salesoft.vn/api/Auth';

  Future<bool> login(String ma, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'ma': ma,
        'matKhau': password,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);
      await prefs.setString('ma', ma);
      return true;
    } else {
      print('Đăng nhập không thành công: ${response.body}');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('ma');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('ma');
  }

  Future<String?> get ma async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ma');
  }

  Future<AuthService> init() async {
    return this;
  }
}
