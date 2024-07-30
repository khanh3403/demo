
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IThongBaoProvider {
  Future<dynamic> getThongBao({required int pageSize, required int pageIndex});
}

class ThongBaoProviderAPI implements IThongBaoProvider {
  final AuthService authService;

  ThongBaoProviderAPI(this.authService);
  @override
  Future<dynamic> getThongBao(
      {required int pageSize, required int pageIndex}) async {
    final maFromPrefs = await authService.ma;
    final urlEndPoint =
        "${URLHelper.NS_ThongBao}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
