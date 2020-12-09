import 'package:app_inter_2/authentications_pages/splash_page.dart';
import 'package:app_inter_2/localization/Demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  static setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('ar', 'SA');

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocale) {
        for (var locale in supportedLocale) {
          if (locale.languageCode == deviceLocale.languageCode) {
            return locale;
          }
        }

        return supportedLocale.first;
      },
      supportedLocales: [
        const Locale('ar', 'SA'),
        const Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
