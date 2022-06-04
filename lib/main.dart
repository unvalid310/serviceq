// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/helper/router_helper.dart';
import 'package:serviceq/provider/auth_provider.dart';
import 'package:serviceq/provider/bengkel_provider.dart';
import 'package:serviceq/provider/favorit_provider.dart';
import 'package:serviceq/provider/filter_provider.dart';
import 'package:serviceq/provider/history_provider.dart';
import 'package:serviceq/provider/language_provider.dart';
import 'package:serviceq/provider/localization_provider.dart';
import 'package:serviceq/provider/lokasi_provider.dart';
import 'package:serviceq/provider/rating_provider.dart';
import 'package:serviceq/provider/rekomendasi_provider.dart';
import 'package:serviceq/provider/sparepart_provider.dart';
import 'package:serviceq/provider/theme_provider.dart';
import 'package:serviceq/provider/tipe_bengkel_provider.dart';
import 'package:serviceq/provider/ulasan_provider.dart';
import 'package:serviceq/theme/dark_theme.dart';
import 'package:serviceq/theme/light_theme.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:serviceq/utill/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'di_container.dart' as di;
import 'localization/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<LocalizationProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<LokasiProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<SparepartProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<FavoritProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<BengkelProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<RekomendasiProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<UlasanProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<RatingProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<FilterProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<HistoryProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<TipeBengkelProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  String initalRoutes = Routes.LOGIN_SCREEN;

  @override
  void initState() {
    super.initState();
    RouterHelper.setupRouter();
    checking();
  }

  Future<void> checking() async {
    // melakukan pengecekan status login
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      setState(() {
        // apabila sudah melakukan login makan akan dikembalikan kehalaman main
        initalRoutes = Routes.DASHBOARD;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: initalRoutes,
          onGenerateRoute: RouterHelper.router.generator,
          title: 'serviceq',
          navigatorKey: MyApp.navigatorKey,
          theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: _locals,
        );
      },
    );
  }
}
