
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class NSUpdate {
  Future<dynamic> NSUpdateInfo(
      { required String cot, required String duLieu});
}

class NSUpdateAPI implements NSUpdate {
  final AuthService authService;
  NSUpdateAPI(this.authService);

  @override
  Future<dynamic> NSUpdateInfo(
      {
      required String cot,
      required String duLieu}) async {
        final maFromPrefs=await authService.ma;
    final urlEndPoint =
        "${URLHelper.NS_InforUpdate}?Ma=$maFromPrefs&Cot=$cot&Dulieu=$duLieu";

    return await HttpUtil().put(urlEndPoint);
  }
}
