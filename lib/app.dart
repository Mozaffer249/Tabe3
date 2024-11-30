import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/lang/languages.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.langCode,
  }) : super(key: key);

  final String langCode;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Tabee3",
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Locale(langCode),
      fallbackLocale: Locale('ar', 'SA'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('ar', 'SA'),
      ],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: kMainColor,
        // colorScheme: ColorScheme.fromSwatch().copyWith(primary: backgroundAppColor),

        unselectedWidgetColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: kMainColor,
          elevation: 0.0,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          toolbarTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: const Color(0xff2d264b),
            fontWeight: FontWeight.w700,
          ),
        ),

        //text theme which contains all text styles

        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: kMainColor),
      ),
    );
  }
}
