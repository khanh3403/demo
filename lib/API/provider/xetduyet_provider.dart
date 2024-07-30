

import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IXetDuyetProvider {
  Future<dynamic> getXetDuyet({required String ma});
}

class XetDuyetProviderAPI implements IXetDuyetProvider {
  final AuthService authService;

  XetDuyetProviderAPI(this.authService);
  @override
  Future<dynamic> getXetDuyet({required String ma}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_XetDuyet}?Ma=$maFromPrefs&TinhTrang=0";
    return await HttpUtil().get(urlEndPoint);
  }
}

abstract class IDaDuyetProvider {
  Future<dynamic> getDaDuyet({required String ma});
}

class DaDuyetProviderAPI implements IDaDuyetProvider {
  final AuthService authService;

  DaDuyetProviderAPI(this.authService);
  @override
  Future<dynamic> getDaDuyet({required String ma}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_XetDuyet}?Ma=$maFromPrefs&TinhTrang=1";
    return await HttpUtil().get(urlEndPoint);
  }
}