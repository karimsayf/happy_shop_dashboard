import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:menu_dashboard/view_model/add_banner_view_model.dart';
import 'package:menu_dashboard/view_model/add_product_color_view_model.dart';
import 'package:menu_dashboard/view_model/add_product_size_view_model.dart';
import 'package:menu_dashboard/view_model/add_product_view_model.dart';
import 'package:menu_dashboard/view_model/add_section_view_model.dart';
import 'package:menu_dashboard/view_model/banners_view_model.dart';
import 'package:menu_dashboard/view_model/edit_banner_view_model.dart';
import 'package:menu_dashboard/view_model/edit_section_view_model.dart';
import 'package:menu_dashboard/view_model/product_colors_view_model.dart';
import 'package:menu_dashboard/view_model/product_sizes_view_model.dart';
import 'package:menu_dashboard/view_model/product_view_model.dart';
import 'package:menu_dashboard/view_model/requests_view_model.dart';
import 'package:menu_dashboard/view_model/sections_view_model.dart';
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
import 'view_model/edit_product_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => AddEmployeeViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductSizeViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductColorViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductViewModel()),
        ChangeNotifierProvider(create: (_) => AddSectionViewModel()),
        ChangeNotifierProvider(create: (_) => AuthFormProvider()),
        ChangeNotifierProvider(create: (_) => EditEmployeeViewModel()),
        ChangeNotifierProvider(create: (_) => EditProductViewModel()),
        ChangeNotifierProvider(create: (_) => EditSectionViewModel()),
        ChangeNotifierProvider(create: (_) => EmployeesViewModel()),
        ChangeNotifierProvider(create: (_) => GeneralViewModel()),
        ChangeNotifierProvider(create: (_) => ProductSizesViewModel()),
        ChangeNotifierProvider(create: (_) => ProductColorsViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => RequestsViewModel()),
        ChangeNotifierProvider(create: (_) => SectionsViewModel()),
        ChangeNotifierProvider(create: (_) => BannersViewModel()),
        ChangeNotifierProvider(create: (_) => AddBannerViewModel()),
        ChangeNotifierProvider(create: (_) => EditBannerViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
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
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).loadUserDataFromFSS().then((_) {
      FlutterNativeSplash.remove();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Shop Dashboard',
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
