import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IListNghiPhepProvider {
  Future<dynamic> getListNghiPhep(
      {required String ma,required String thang,required String nam});
}

class ListNghiPhepProviderAPI implements IListNghiPhepProvider {
  final AuthService authService;

  ListNghiPhepProviderAPI(this.authService);
  @override
  Future<dynamic> getListNghiPhep(
      {required String ma,required String thang,required String nam}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.DM_NghiPhep}?Ma=$maFromPrefs&Thang=$thang&Nam=$nam";
    return await HttpUtil().get(urlEndPoint);
  }
}
