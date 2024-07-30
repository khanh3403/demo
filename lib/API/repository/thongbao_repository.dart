
import 'package:salesoft_hrm/API/provider/thongbao_provider.dart';
import 'package:salesoft_hrm/model/thongbao_model.dart';

abstract class IThongBaoRepository {
  Future<ThongBao> getThongBao({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  });
}

class ThongBaoRepository implements IThongBaoRepository {
  final IThongBaoProvider provider;
  ThongBaoRepository({
    required this.provider,
  });
  @override
  Future<ThongBao> getThongBao({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  }) async {
    final response =
        provider.getThongBao(pageSize: pageSize, pageIndex: pageIndex);

    return response.then<ThongBao>((value) {
      if (value != null) {
        return Future<ThongBao>.value(ThongBao.fromJson(value));
      } else {
        // ignore: null_argument_to_non_null_type
        return Future<ThongBao>.value();
      }
    }).catchError((onError) {
      print('Error during API call: $onError');
      // ignore: null_argument_to_non_null_type
      return Future<ThongBao>.value();
    });
  }
}
