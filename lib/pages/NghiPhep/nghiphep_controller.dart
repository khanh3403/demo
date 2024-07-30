import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/list_nghiphep_provider.dart';
import 'package:salesoft_hrm/API/repository/list_nghiphep_respository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/model/list_nghiphep_model.dart';

class NghiPhepController extends GetxController with StateMixin<ListNghiPhep> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ListNghiPhep? contentDisplay;
  ListNghiPhep? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;
   String thang = ''; 
  String nam = ''; 

  final ListNghiPhepRepository _listNghiPhepRepository =
      ListNghiPhepRepository(provider: ListNghiPhepProviderAPI(AuthService()));

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
  }

  Future<void> fetchMaAndListContent() async {
    final authService = Get.find<AuthService>();
    ma = (await authService.ma) ?? '';
    if (ma.isNotEmpty) {
      fetchListContent();
    } else {
      change(null, status: RxStatus.error('Không lấy được mã người dùng'));
    }
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _listNghiPhepRepository.getListNghiPhep(
      thang:thang,
      nam:nam,
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result != null) {
      if (isLoadMore) {
        contentDisplay?.data?.addAll(result.data ?? []);
      } else {
        contentDisplay = result;
        originalContentDisplay = result;
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay!.data!.isEmpty) {
        change(contentDisplay, status: RxStatus.empty());
      } else {
        change(contentDisplay, status: RxStatus.success());
      }
    } else {
      if (isLoadMore) {
        refreshController.loadNoData();
      } else {
        change(null, status: RxStatus.empty());
      }
    }
  }
}
