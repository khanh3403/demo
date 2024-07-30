import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNghiPhepItemView extends StatefulWidget {
  final String? loaiNghi;
  final String? lyDo;
  final int? tinhTrang;
  final String? soLuong;
  final String? tuNgay; 
  final String? denNgay; 
  const ListNghiPhepItemView({
    Key? key,
    this.loaiNghi,
    this.lyDo,
    this.tinhTrang,
    this.soLuong,
    this.tuNgay, 
    this.denNgay, 
  }) : super(key: key);

  @override
  _ListNghiPhepItemViewState createState() => _ListNghiPhepItemViewState();
}

class _ListNghiPhepItemViewState extends State<ListNghiPhepItemView> {
  bool _isExpanded = false; 

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr; // Nếu không thể định dạng, trả về chuỗi gốc
    }
  }

  String formatSoLuong(String? soLuong) {
    if (soLuong == null || soLuong.isEmpty) {
      return '';
    }
    try {
      final double value = double.parse(soLuong);
      if (value == value.toInt()) {
        return value.toInt().toString(); // Loại bỏ phần thập phân nếu bằng 0
      }
      return value.toString();
    } catch (e) {
      return soLuong; // Nếu không thể định dạng, trả về chuỗi gốc
    }
  }

  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor;
    String tinhTrangText;

    switch (widget.tinhTrang) {
      case 0:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Chờ duyệt';
        break;
      case 1:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã duyệt';
        break;
      case 2:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không duyệt';
        break;
      default:  
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không xác định';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), 
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 40,
                      child: Text(
                        widget.loaiNghi ?? '',
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                  ),
                  Expanded(
                    flex: 30,
                      child: Text(
                        formatSoLuong(widget.soLuong)+' ngày',
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                      child: Text(
                        tinhTrangText,
                        style: TextStyle(color: tinhTrangColor, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            if (_isExpanded) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '- Lý do: ${widget.lyDo ?? ''}',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      '- Từ ngày: ${formatDate(widget.tuNgay)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      '- Đến ngày: ${formatDate(widget.denNgay)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
