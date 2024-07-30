import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/XetDuyet/put_xetduyet.dart';

class XetDuyetItemView extends StatefulWidget {
  final String? loai;
  final int? id;
  final String? ngay;
  final String? dieuKien;
  final String? noiDung;
  final String? capDuyet;
  bool? tinhTrang;

  XetDuyetItemView({
    Key? key,
    this.loai,
    this.ngay,
    this.id,
    this.dieuKien,
    this.tinhTrang,
    this.noiDung,
    this.capDuyet,
  }) : super(key: key);

  @override
  _XetDuyetItemViewState createState() => _XetDuyetItemViewState();
}

class _XetDuyetItemViewState extends State<XetDuyetItemView> {
  bool _isExpanded = false;

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  void _showConfirmDialog(BuildContext context, String action) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(action == 'Duyệt' ? 'Xác nhận Duyệt' : 'Xác nhận Không Duyệt'),
          content: Text('Bạn có chắc chắn muốn $action không?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Xác nhận'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                if (action == 'Duyệt') {
                  confirmDuyet(widget.id!);
                } else {
                  confirmKhongDuyet(widget.id!);
                }
              },
            ),
          ],
        );
      },
    );
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
        child: Column(
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  'Cấp duyệt: ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                Text(
                  widget.capDuyet ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.red,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  widget.loai ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                Text(
                  formatDate(widget.ngay) ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.noiDung ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, 
              children: [
                const SizedBox(width: 30),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _showConfirmDialog(context, 'Không Duyệt');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color:const Color.fromRGBO(246, 183, 183, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Không Duyệt',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:const Color.fromRGBO(230, 98, 107, 1),
                            fontSize: 12,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _showConfirmDialog(context, 'Duyệt');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(173, 236, 193, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Duyệt',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:const Color.fromRGBO(62, 199, 97, 1.0),
                            fontSize: 12,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
