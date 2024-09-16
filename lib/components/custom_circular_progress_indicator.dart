import 'dart:io';

import 'package:flutter/cupertino.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double iosSize;
  final Color color;

  const CustomCircularProgressIndicator(
      {super.key,
      required this.iosSize,
      required this.color});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
          height: iosSize,
          width: iosSize,
          child: CupertinoActivityIndicator(
            color: color,
          ));
  }
}
