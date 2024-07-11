import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class INhanSuInfoDtProvider {
  Future<List<dynamic>?> getNhanSuInfoDt({required String ma});
}

class NhanSuInfoDtProviderAPI implements INhanSuInfoDtProvider {
  @override
  Future<List<dynamic>?> getNhanSuInfoDt({required String ma}) async {
    final urlEndPoint = "${URLHelper.NS_Information}?Ma=$ma";
    try {
      final response = await HttpUtil().get(urlEndPoint);
      if (response != null && response is List) {
        return response;
      } else {
        print('Invalid response format: $response');
        return null;
      }
    } catch (error) {
      print('Error fetching Nhan Su info: $error');
      return null;
    }
  }
}
