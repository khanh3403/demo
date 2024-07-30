

import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';

abstract class ILoaiNghiProvider {
  Future<dynamic> getLoaiNghi(
      {required String table});
}

class LoaiNghiProviderAPI implements ILoaiNghiProvider {
  LoaiNghiProviderAPI();

  @override
  Future<List<dynamic>?> getLoaiNghi({required String table}) async {
    const urlEndPoint = "${URLHelper.DM_LoaiNghi}?Table=DM_LoaiNghi";
    final response = await HttpUtil().get(urlEndPoint);
    return response as List<dynamic>; 
  }
}

