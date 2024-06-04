import 'package:flutter/material.dart';

class ReusableRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRowWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider()
      ],
    );
  }
}
