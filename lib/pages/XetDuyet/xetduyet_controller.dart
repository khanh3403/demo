import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/xetduyet_provider.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/xetduyet_repository.dart';
import 'package:salesoft_hrm/model/xetduyet_model.dart';

class XetDuyetController extends GetxController with StateMixin<List<XetDuyet>> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<XetDuyet> contentDisplay = [];
  List<XetDuyet> originalContentDisplay = [];
  int pageIndex = 1;
  int pageSize = 10;
  late String ma;

  final XetDuyetRepository _xetDuyetRepository =
      XetDuyetRepository(provider: XetDuyetProviderAPI(AuthService()));

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
      contentDisplay.clear();
      refreshController.resetNoData();
    }

    final result = await _xetDuyetRepository.getXetDuyet(
      ma: ma,
    );

    print('Kết quả API: $result');

    if (result != null) {
      if (isLoadMore) {
        contentDisplay.addAll(result);
      } else {
        contentDisplay = result;
        originalContentDisplay = List.from(result);
      }

      refreshController.loadComplete();
      pageIndex += 1;

      if (contentDisplay.isEmpty) {
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
