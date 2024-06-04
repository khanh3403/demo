import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/nhansu_provider.dart';
import 'package:salesoft_hrm/API/repository/NS_Infomation.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/NSInfo_model.dart';

class HomeController extends GetxController {
  final NSInfoRepository _nsInfoRepository =
      NSInfoRepository(provider: NhanSuInfoProviderAPI(AuthService()));

  var hoDem = ''.obs;
  var ten = ''.obs;
  var gioiTinh = ''.obs;
  var kh = ''.obs;
  var chucVu = ''.obs;
  var phongBan = ''.obs;
  var ngaySinh = ''.obs;
  var soHd = ''.obs;
  var ngayKyHd = ''.obs;
  var dcll = ''.obs;
  var dienThoai = ''.obs;
  var email = ''.obs;
  var toCongTac = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final ma = await AuthService().ma;
      if (ma != null) {
        final nsInfo = await _nsInfoRepository.getNhanSuInfo(ma: ma);
        hoDem.value = nsInfo.hoDem ?? '';
        ten.value = nsInfo.ten ?? '';
        gioiTinh.value = nsInfo.gioiTinh ?? '';
        kh.value = nsInfo.kh ?? '';
        chucVu.value = nsInfo.chucVu ?? '';
        phongBan.value = nsInfo.phongBan ?? '';
        ngaySinh.value = nsInfo.ngaySinh ?? '';
        soHd.value = nsInfo.soHd ?? '';
        ngayKyHd.value = nsInfo.ngayKyHd ?? '';
        dcll.value = nsInfo.dcll ?? '';
        dienThoai.value = nsInfo.dienThoai ?? '';
        email.value = nsInfo.email ?? '';
        toCongTac.value = nsInfo.toCongTac ?? '';
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }
}
