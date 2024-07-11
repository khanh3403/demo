import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class ApprovedItemView extends StatelessWidget {
  final String? cotDuLieu;
  final String? duLieu;


  const ApprovedItemView({
    Key? key,
    this.cotDuLieu,
    this.duLieu,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeWidth(context) * 0.03,
        ),
              RowHoSo(text1: cotDuLieu??'', text2: duLieu ?? ''),
        
      ],
    );
  }
}
