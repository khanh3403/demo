import 'package:salesoft_hrm/API/provider/danhba_dt/danhba_detail_provider.dart';
import 'package:salesoft_hrm/model/NSInfo_model.dart';

abstract class INSInfoDtRepository {
  Future<NsInfo> getNhanSuInfoDt({
    required String ma,
  });
}

class NSInfoDtRepository implements INSInfoDtRepository {
  final INhanSuInfoDtProvider provider;

  NSInfoDtRepository({
    required this.provider,
  });

  @override
  Future<NsInfo> getNhanSuInfoDt({required String ma}) async {
    try {
      final response = await provider.getNhanSuInfoDt(ma: ma);
      if (response != null && response is List && response.isNotEmpty) {
        final firstItem = response[0];
        if (firstItem is Map<String, dynamic>) {
          return NsInfo.fromJson(firstItem);
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('No data received from API');
      }
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}
