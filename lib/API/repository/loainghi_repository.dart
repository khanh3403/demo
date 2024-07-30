import 'package:salesoft_hrm/API/provider/loainghi_provider.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';

abstract class ILoaiNghiRepository {
  Future<LoaiNghiResponse?> getLoaiNghi({
    required String table,
  });
}

class LoaiNghiRepository implements ILoaiNghiRepository {
  final ILoaiNghiProvider provider;

  LoaiNghiRepository({required this.provider});

  @override
  Future<LoaiNghiResponse?> getLoaiNghi({required String table}) async {
    try {
      final response = await provider.getLoaiNghi(table: table);
      if (response != null) {
        final loaiNghiResponse = LoaiNghiResponse.fromJson(response);
        return loaiNghiResponse;
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}

