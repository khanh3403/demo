import 'package:salesoft_hrm/API/provider/not_approved_provider.dart';
import 'package:salesoft_hrm/model/not_approved_model.dart';

abstract class INotApprovedRepository {
  Future<List<Approved>?> getNotApproved({
    required String ma,
  });
}

class NotApprovedRepository implements INotApprovedRepository {
  final INotApprovedProvider provider;
  NotApprovedRepository({
    required this.provider,
  });

  @override
  Future<List<Approved>?> getNotApproved({
    required String ma,
  }) async {
    try {
      final response = await provider.getNotApproved(ma: ma);
      if (response != null) {
        if (response is List<dynamic>) {
          print('Phản hồi từ API: $response');  // Ghi log phản hồi từ API
          return response.map((e) => Approved.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          throw Exception('Invalid response format: Expected List<dynamic>, got ${response.runtimeType}');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (onError) {
      print('Lỗi trong quá trình gọi API: $onError');
      return null;
    }
  }
}
