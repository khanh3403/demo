import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListChamCongItemView extends StatefulWidget {
  final String? caLamViec;
  final String? diaDiem;
  final bool? checkIn;
  final String? thoiGian;
  final String? lyDo;

  const ListChamCongItemView({
    Key? key,
    this.caLamViec,
    this.diaDiem,
    this.checkIn,
    this.thoiGian,
    this.lyDo,
  }) : super(key: key);

  @override
  _ListChamCongItemViewState createState() => _ListChamCongItemViewState();
}

class _ListChamCongItemViewState extends State<ListChamCongItemView> {
  bool _isExpanded = false; 

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('HH:mm:ss dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), 
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Center(
                      child: Text(
                        _formatDate(widget.thoiGian),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        widget.checkIn == true ? 'Vào' : 'Ra',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
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
                    '- Ca làm việc: ${widget.caLamViec ?? ''}',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '- Địa điểm: ${widget.diaDiem ?? ''}',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '- Lý do: ${widget.lyDo ?? ''}',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
