import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetocompleto2/models/transitions_page.dart';

abstract class Routes {
  static const homePage = '/';

  static final pagesDetails = <Map<String, dynamic>>[
    {
      'route': homePage,
    },
  ];

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    assert(
      settings.arguments is TransitionsPage, 
      'Sempre passar como arguments de uma página um TransitionsPage, sendo'
      ' que nele é possível passar o argument e o que for necessário, além '
      'de ser possível expandí-lo'
    );

    final TransitionsPage page = settings.arguments;
    return _defaultRoute(
      routeSettings: settings,
      fullscreenDialog: page.fullscreenDialog,
      maintainState: page.maintainState,
      builder: page.builder,
    );
  }
  
  static Route<dynamic> _defaultRoute({
    RouteSettings routeSettings,
    bool fullscreenDialog,
    bool maintainState,
    WidgetBuilder builder,
  }) {
    //TODO! animação
    return MaterialPageRoute(
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      builder: builder,
      settings: routeSettings,
    );
  }
}