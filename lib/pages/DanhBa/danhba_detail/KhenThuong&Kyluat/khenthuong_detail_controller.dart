import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/danhba_dt/khenthuong_detail_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_dt/khenthuong_detail_repository.dart';
import 'package:salesoft_hrm/model/khenthuong_model.dart';

class KhenThuongDtController extends GetxController
    with StateMixin<Khenthuong> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Khenthuong? contentDisplay;
  Khenthuong? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 10;
  late String ma = '';

  final KhenthuongDtRepository _khenthuongRepository =
      KhenthuongDtRepository(provider: KhenThuongDtProviderAPI());

  @override
  void onInit() {
    super.onInit();
    fetchMaAndListContent();
  }

  Future<void> fetchMaAndListContent() async {
    final args = Get.arguments as Map<String, dynamic>;
    ma = args['ma'] as String;

    fetchListContent();
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _khenthuongRepository.getKhenThuongDt(
      pageSize: pageSize,
      pageIndex: pageIndex,
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
