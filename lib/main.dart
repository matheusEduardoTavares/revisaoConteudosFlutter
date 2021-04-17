import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetocompleto2/providers/configs/configs.dart';
import 'package:projetocompleto2/utils/navigator_config.dart';
import 'dart:async';

import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_page_transitions_builder/custom_page_transitions_builder.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (!kReleaseMode) {
    print('1');
    scheduleMicrotask(() => print('2'));
    print('3');
    Future(() {
      print('print com future');
    });
    scheduleMicrotask(() => print('4'));
    await Future.delayed(const Duration(seconds: 1));
    print('5');
  }

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.light
  // ));

  final _primaryColor = Colors.purple;
  final _accentColor = Colors.orangeAccent;

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => Configs(),
      lazy: true,
      builder: (ctx, _) {
        final brightness = Provider.of<Configs>(ctx).appBrightness;
        final _isDarkMode = brightness == Brightness.dark;
        return MaterialApp(
          title: 'ProjectComplete',
          onGenerateRoute: Routes.onGenerateRoutes,
          navigatorKey: NavigatorConfig.navKey,
          theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionsBuilder()
              },
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: _primaryColor,
              brightness: Brightness.dark,
              centerTitle: true,
            ),
            primaryColor: _primaryColor,
            accentColor: _accentColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_primaryColor),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  _isDarkMode ? Colors.white : _primaryColor,
                ),
                overlayColor: MaterialStateProperty.all(
                  _isDarkMode ? Colors.grey.withOpacity(0.2) : 
                    Colors.purple.withOpacity(0.2)
                ),
              ),
            ),
            brightness: brightness,
          ),
        );
      },
    ),
  );
}