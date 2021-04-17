import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetocompleto2/models/details_page.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/home_page/home_page.dart';
import 'package:projetocompleto2/pages/top_tab_page/top_tab_page.dart';
import 'package:projetocompleto2/widgets/custom_material_page_route/custom_material_page_route.dart';

abstract class Routes {
  static const homePage = '/';
  static const topTabPage = '/top_tab';

  static final detailsPage = <DetailsPage>[
    DetailsPage(
      name: 'HomePage', 
      goToNamedRoute: homePage,
      leading: Icon(Icons.home),
      transitionsPage: TransitionsPage(
        builder: (ctx) => HomePage(),
      ),
    ),
    DetailsPage(
      name: 'TopTab', 
      goToNamedRoute: topTabPage,
      leading: Icon(Icons.topic),
      transitionsPage: TransitionsPage(
        builder: (ctx) => TopTabPage(),
      ),
    ),
  ];

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    assert(
      settings.arguments == null || settings.arguments is TransitionsPage, 
      'Sempre passar como arguments de uma página um TransitionsPage, sendo'
      ' que nele é possível passar o argument e o que for necessário, além '
      'de ser possível expandí-lo'
    );

    final TransitionsPage page = settings.arguments;
    return _defaultRoute(
      routeSettings: settings,
      fullscreenDialog: page?.fullscreenDialog ?? false,
      maintainState: page?.maintainState ?? true,
      builder: page?.builder,
      hasAnimation: page?.hasAnimation,
    );
  }
  
  static Route<dynamic> _defaultRoute({
    RouteSettings routeSettings,
    bool fullscreenDialog = false,
    bool maintainState = true,
    WidgetBuilder builder,
    bool hasAnimation = true,
  }) {
    return CustomMaterialPageRoute(
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
      builder: builder ?? (ctx) => HomePage(),
      settings: routeSettings,
      hasAnimation: hasAnimation ?? true,
    );
  }
}