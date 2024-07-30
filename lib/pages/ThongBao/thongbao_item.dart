import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class ThongBaoItemView extends StatelessWidget {
  final String? tieuDe;
  final String? noiDung;
  final bool? daXem;
  final String? date1;
  final Function(String?)? onTap;

  const ThongBaoItemView({
    Key? key,
    this.onTap,
    this.tieuDe,
    this.noiDung,
    this.daXem,
    this.date1,
  }) : super(key: key);

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
    return InkWellWidget(
      // onPress: () => onTap?.call(ma),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/icon_app2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tieuDe ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
                    Text(
                      noiDung ?? '',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
                    Text(
                      _formatDate(date1),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
