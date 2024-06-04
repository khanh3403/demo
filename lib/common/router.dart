import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/khenthuong_kyluat_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTCongTac/congtac_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/infomation_page.dart';
import 'package:salesoft_hrm/pages/HoSo/hoso_page.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_page.dart';

enum ERouter {
  mainPage,
  chamCong,
  hoSo,
  nghiPhep,
  danhBa,
  information,
  quanhe,
  qtCongTac,
  ktkl,
}

extension ERouterExt on ERouter {
  String get name {
    switch (this) {
      case ERouter.mainPage:
        return "/main_page";
      case ERouter.chamCong:
        return "/cham_cong";
      case ERouter.hoSo:
        return "/ho_so";
      case ERouter.nghiPhep:
        return "/nghiPhep";
      case ERouter.danhBa:
        return "/danhBa";
      case ERouter.information:
        return "/information";
      case ERouter.quanhe:
        return "/quanhe";
      case ERouter.qtCongTac:
        return "/qtCongTac";
      case ERouter.ktkl:
        return "/khenthuongkyluat";
      default:
        return "/";
    }
  }
}

class RouterPage {
  static final routers = [
    GetPage(
      name: ERouter.mainPage.name,
      page: () => MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: ERouter.chamCong.name,
      page: () => const ChamCongPage(),
    ),
    GetPage(
      name: ERouter.hoSo.name,
      page: () => const HoSoPage(),
    ),
    GetPage(
      name: ERouter.nghiPhep.name,
      page: () => const NghiPhepPage(),
    ),
    GetPage(
      name: ERouter.danhBa.name,
      page: () => DanhBaPage(),
    ),
    GetPage(name: ERouter.information.name, page: () => MyInformation()),
    GetPage(
      name: ERouter.quanhe.name,
      page: () => QuanHePage(),
    ),
    GetPage(
      name: ERouter.qtCongTac.name,
      page: () => CongTacPage(),
    ),
    GetPage(
      name: ERouter.ktkl.name,
      page: () => KTKLPage(),
    )
  ];
}

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IDanhBaProvider>(
      () => DanhBaProviderAPI(),
      fenix: true,
    );
    Get.lazyPut<IDanhBaRepository>(
      () => DanhBaRepository(provider: Get.find()),
      fenix: true,
    );
    Get.put(MainController());
  }
}
