import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> postNewInfo(Map<String, dynamic> data) async {
  final url = 'https://api.salesoft.vn/api/nhanSuQH/Update';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_ACCESS_TOKEN', 
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Thêm thông tin mới thành công');
  } else {
    print('Thêm thông tin mới thất bại: ${response.statusCode}');
  }
}
