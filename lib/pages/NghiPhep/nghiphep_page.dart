import 'package:flutter/material.dart';
import 'package:salesoft_hrm/widgets/appbar_container_widget.dart';

class NghiPhepPage extends StatelessWidget {
  const NghiPhepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBarContainerWidget(
      title: Text(
        'Nghỉ phép',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
