
import 'package:salesoft_hrm/API/provider/list_chamcong_provider.dart';
import 'package:salesoft_hrm/API/provider/list_nghiphep_provider.dart';
import 'package:salesoft_hrm/model/list_chamcong_model.dart';
import 'package:salesoft_hrm/model/list_nghiphep_model.dart';

abstract class IListNghiPhepRepository {
  Future<ListNghiPhep?> getListNghiPhep({
    required String ma,
    required String thang,
    required String nam,
  });
}

class ListNghiPhepRepository implements IListNghiPhepRepository {
  final IListNghiPhepProvider provider;
  ListNghiPhepRepository({
    required this.provider,
  });
  @override
  Future<ListNghiPhep?> getListNghiPhep({
    required String ma,
    required String thang,
    required String nam
  }) async {
    try {
      final response = await provider.getListNghiPhep(ma: ma,thang:thang,nam:nam);
    if (response != null) {
        if (response is Map<String, dynamic>) {
          return ListNghiPhep.fromJson(response);
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
