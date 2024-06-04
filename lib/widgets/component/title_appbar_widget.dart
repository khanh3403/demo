import 'package:flutter/material.dart';

class TitleAppBarWidget extends StatelessWidget {
  const TitleAppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
    );
  }
}
