import 'package:salesoft_hrm/API/provider/Qlluong_provider.dart';
import 'package:salesoft_hrm/API/provider/quanhe_provider.dart';
import 'package:salesoft_hrm/model/Qtluong_model.dart';
import 'package:salesoft_hrm/model/quanhe_model.dart';

abstract class ILuongRepository {
  Future<Qtluong?> getLuong({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class LuongRepository implements ILuongRepository {
  final ILuongProvider provider;
  LuongRepository({
    required this.provider,
  });
  @override
  Future<Qtluong?> getLuong({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getLuong(
          pageSize: pageSize, pageIndex: pageIndex, ma: ma);
    if (response != null) {
        if (response is Map<String, dynamic>) {
          return Qtluong.fromJson(response);
        } else {
          throw Exception('Invalid response format');
        }
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}
