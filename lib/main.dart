import 'package:flutter/material.dart';
import 'dart:async';

import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/custom_page_transitions_builder/custom_page_transitions_builder.dart';

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

  runApp(
    MaterialApp(
      title: 'ProjectComplete',
      onGenerateRoute: Routes.onGenerateRoutes,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder()
          }
        ),
      ),
    ),
  );
}