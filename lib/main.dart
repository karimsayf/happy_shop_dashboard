import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utilities/colors.dart';
import 'utilities/constants.dart';
import 'utilities/navigation_service.dart';
import 'view/auth/authentication.dart';
import 'view/main_screen/main_screen.dart';
import 'view_model/add_employee_view_model.dart';
import 'view_model/api_services_view_model.dart';
import 'view_model/auth_form_provider.dart';
import 'view_model/edit_employee_view_model.dart';
import 'view_model/employees_view_model.dart';
import 'view_model/general_view_model.dart';
import 'view_model/user_view_model.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiServicesViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => GeneralViewModel()),
        ChangeNotifierProvider(create: (_) => AuthFormProvider()),
        ChangeNotifierProvider(create: (_) => EmployeesViewModel()),
        ChangeNotifierProvider(create: (_) => AddEmployeeViewModel()),
        ChangeNotifierProvider(create: (_) => EditEmployeeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UserViewModel>(context, listen: false).loadUserDataFromFSS();
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Dashboard',
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: NavigationService.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('ar'),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.c991,
          fontFamily: stcFontStr),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: 'MOBILE'),
          const ResponsiveBreakpoint.autoScale(450, name: 'MOBILE'),
          const ResponsiveBreakpoint.autoScale(800, name: 'TABLET'),
          const ResponsiveBreakpoint.autoScale(1000, name: 'TABLET'),
          const ResponsiveBreakpoint.resize(1200, name: 'DESKTOP'),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
      home: Provider.of<UserViewModel>(context, listen: true).userToken.isNotEmpty
          ? const MainScreen()
          : const Authentication(),
    );
  }
}
