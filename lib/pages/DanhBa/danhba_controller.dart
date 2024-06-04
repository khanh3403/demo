import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/model/danhba_model.dart';

class DanhBaController extends GetxController with StateMixin<Danhba> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Danhba? contentDisplay;
  Danhba? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 1;

  final IDanhBaRepository _repository = Get.find();

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

    final result = await _repository.getDanhBa(
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
  void searchDanhBa(String query) {
    if (query.isEmpty) {
      contentDisplay = originalContentDisplay;
    } else {
      final filteredData = originalContentDisplay?.data?.where((item) {
        final name = '${item.hoDem} ${item.ten}'.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
      contentDisplay = Danhba(data: filteredData);
    }
    change(contentDisplay, status: RxStatus.success());
  }
}
