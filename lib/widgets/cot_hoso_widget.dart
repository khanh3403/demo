import 'package:flutter/widgets.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';

class RowHoSo extends StatelessWidget {
  final String text1;
  final String text2;

  const RowHoSo({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppConstant.getScreenSizeWidth(context) * 0.05,
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: Text(
              text1,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: Text(
              text2,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
