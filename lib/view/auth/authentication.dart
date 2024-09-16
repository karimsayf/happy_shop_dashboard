import 'package:flutter/material.dart';

import '../responsive/responsive_layout.dart';
import 'widgets/auth_desktop_view.dart';
import 'widgets/auth_mobile_view.dart';
import 'widgets/auth_tablet_view.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ResponsiveLayout(
            mobile: AuthMobileView(),
            tablet: AuthTabletView(),
            desktop: AuthDesktopView()));
  }
}
