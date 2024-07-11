import 'package:salesoft_hrm/API/provider/calamviec_provider.dart';
import 'package:salesoft_hrm/model/calamviec_model.dart';

enum Ngay { ToanBo, Thu7, ChuNhat }

Ngay getNgay(String ngayString) {
  switch (ngayString) {
    case 'ToanBo':
      return Ngay.ToanBo;
    case 'Thu7':
      return Ngay.Thu7;
    case 'ChuNhat':
      return Ngay.ChuNhat;
    default:
      throw Exception('Ngày không hợp lệ: $ngayString');
  }
}

List<CaLamViec> locTheoNgay(List<CaLamViec> danhSachCaLam, Ngay ngay) {
  return danhSachCaLam.where((calam) {
    switch (ngay) {
      case Ngay.ToanBo:
        return calam.ngay == 'ToanBo';
      case Ngay.Thu7:
        return calam.ngay == 'Thu7';
      case Ngay.ChuNhat:
        return calam.ngay == 'ChuNhat';
      default:
        return false;
    }
  }).toList();
}

abstract class ICaLamRepository {
  Future<CaLamList?> getCaLam();
}

class CaLamRepository implements ICaLamRepository {
  final ICaLamProvider provider;

  CaLamRepository({required this.provider});

  @override
  Future<CaLamList?> getCaLam() async {
    try {
      final response = await provider.getCaLam();
      if (response != null) {
        final danhSachCaLam = CaLamList.fromJson(response).caLamList;

        final ngayHienTai = DateTime.now().weekday;

        Ngay ngay;
        switch (ngayHienTai) {
          case DateTime.monday:
          case DateTime.tuesday:
          case DateTime.wednesday:
          case DateTime.thursday:
          case DateTime.friday:
            ngay = Ngay.ToanBo;
            break;
          case DateTime.saturday:
            ngay = Ngay.Thu7;
            break;
          case DateTime.sunday:
            ngay = Ngay.ChuNhat;
            break;
          default:
            throw Exception('Ngày không hợp lệ: $ngayHienTai');
        }

        final danhSachDaLoc = locTheoNgay(danhSachCaLam, ngay);

        return danhSachDaLoc.isNotEmpty
            ? CaLamList(caLamList: danhSachDaLoc)
            : null;
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi trong quá trình gọi API: $e');
      return null;
    }
  }
}
