import 'package:salesoft_hrm/API/provider/xetduyet_provider.dart';
import 'package:salesoft_hrm/model/xetduyet_model.dart';

abstract class IXetDuyetRepository {
  Future<List<XetDuyet>?> getXetDuyet({required String ma});
}

class XetDuyetRepository implements IXetDuyetRepository {
  final IXetDuyetProvider provider;

  XetDuyetRepository({
    required this.provider,
  });

  @override
  Future<List<XetDuyet>?> getXetDuyet({required String ma}) async {
    try {
      final response = await provider.getXetDuyet(ma: ma);
      if (response != null) {
        if (response is List) {
          return response.map((item) => XetDuyet.fromJson(item)).toList();
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
abstract class IDaDuyetRepository {
  Future<List<XetDuyet>?> getDaDuyet({required String ma});
}

class DaDuyetRepository implements IDaDuyetRepository {
  final IDaDuyetProvider provider;

  DaDuyetRepository({
    required this.provider,
  });

  @override
  Future<List<XetDuyet>?> getDaDuyet({required String ma}) async {
    try {
      final response = await provider.getDaDuyet(ma: ma);
      if (response != null) {
        if (response is List) {
          return response.map((item) => XetDuyet.fromJson(item)).toList();
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