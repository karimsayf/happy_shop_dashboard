import 'package:flutter/material.dart';

import 'widgets/add_city_desktop_view.dart';
import 'widgets/add_city_mobile_view.dart';

class AddCity extends StatefulWidget {
  final String pageState;

  const AddCity({super.key, required this.pageState});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const AddCityDesktopView()
        : const AddCityMobileView();
  }
}
