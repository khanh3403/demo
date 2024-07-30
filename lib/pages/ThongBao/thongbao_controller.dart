
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/thongbao_repository.dart';
import 'package:salesoft_hrm/model/thongbao_model.dart';

class ThongBaoController extends GetxController with StateMixin<ThongBao> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ThongBao? contentDisplay;
  ThongBao? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;
 


  final IThongBaoRepository _repository = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchListContent();
  }

  void fetchListContent({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _repository.getThongBao(
      pageSize: pageSize,
      pageIndex: pageIndex,
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
      refreshController.loadNoData();
    }
  }




}
