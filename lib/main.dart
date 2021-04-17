import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetocompleto2/providers/configs/configs.dart';
import 'package:projetocompleto2/utils/navigator_config.dart';
import 'dart:async';

import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_page_transitions_builder/custom_page_transitions_builder.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  print('1');
  scheduleMicrotask(() => print('2'));
  print('3');
  Future(() {
    print('print com future');
  });
  scheduleMicrotask(() => print('4'));
  await Future.delayed(const Duration(seconds: 1));
  print('5');

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.light
  // ));

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => Configs(),
      lazy: true,
      builder: (ctx, _) => MaterialApp(
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
            backgroundColor: Colors.purple,
            brightness: Provider.of<Configs>(ctx).appBrightness == Brightness.dark ?
              Brightness.light : Brightness.dark,
          ),
          primaryColor: Colors.purple,
          accentColor: Colors.orangeAccent,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
          ),
          brightness: Provider.of<Configs>(ctx).appBrightness,
        ),
      ),
    ),
  );
}