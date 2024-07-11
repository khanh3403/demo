import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/not_approved_provider.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/not_approved_repository.dart';
import 'package:salesoft_hrm/model/not_approved_model.dart';

class NotApprovedController extends GetxController with StateMixin<List<Approved>> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List<Approved>? contentDisplay;

  late String ma;

  final NotApprovedRepository _notApprovedRepository = 
      NotApprovedRepository(provider: NotApprovedProviderAPI(AuthService()));

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
      contentDisplay = null;
      refreshController.resetNoData();
    }

    final result = await _notApprovedRepository.getNotApproved(ma: ma);

    print('Kết quả API: $result');  // Ghi log kết quả API

    if (result != null) {
      contentDisplay = result;
      change(contentDisplay, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('Không lấy được dữ liệu'));
    }
  }
}
