import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class INotApprovedProvider {
  Future<List<dynamic>?> getNotApproved({required String ma});
}

class NotApprovedProviderAPI implements INotApprovedProvider {
  final AuthService authService;

  NotApprovedProviderAPI(this.authService);

  @override
  Future<List<dynamic>?> getNotApproved({required String ma}) async {
    final maFromPrefs = await authService.ma;
    if (maFromPrefs != null) {
      final urlEndPoint = "${URLHelper.NS_NotApproved}?Ma=$maFromPrefs&TinhTrang=0";
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
    } else {
      print('User not logged in');
      return null;
    }
  }
}
