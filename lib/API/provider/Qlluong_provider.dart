import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ILuongProvider {
  Future<dynamic> getLuong(
      {required String ma, required int pageSize, required int pageIndex});
}

class LuongProviderAPI implements ILuongProvider {
  final AuthService authService;

  LuongProviderAPI(this.authService);
  @override
  Future<dynamic> getLuong(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_qlLuong}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
