import 'package:salesoft_hrm/API/provider/NS_Update_provider.dart';

abstract class IUpdateInfoRepository {
  Future<dynamic> NSUpdateAPI({
    required String cot,
    required String duLieu,
  });
}

class NSUpdateInfoRepository implements IUpdateInfoRepository {
  final NSUpdate provider;

  NSUpdateInfoRepository({
    required this.provider,
  });

  @override
  Future<dynamic> NSUpdateAPI({
    required String cot,
    required String duLieu,
  }) async {
    try {
           final response = await provider.NSUpdateInfo(cot:cot,duLieu:duLieu);
      return response; 
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}
