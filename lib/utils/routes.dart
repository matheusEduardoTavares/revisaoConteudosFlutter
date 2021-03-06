import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetocompleto2/models/details_page.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/bottom_tab_page/bottom_tab_page.dart';
import 'package:projetocompleto2/pages/config_page/config_page.dart';
import 'package:projetocompleto2/pages/form_page/form_page.dart';
import 'package:projetocompleto2/pages/home_page/home_page.dart';
import 'package:projetocompleto2/pages/isolate_page/isolate_page.dart';
import 'package:projetocompleto2/pages/login_page/login_page.dart';
import 'package:projetocompleto2/pages/redux_page/redux_page.dart';
import 'package:projetocompleto2/pages/top_tab_page/top_tab_page.dart';
import 'package:projetocompleto2/pages/user_home_page/user_home_page.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';
import 'package:projetocompleto2/widgets/custom_material_page_route/custom_material_page_route.dart';

abstract class Routes {
  static const homePage = '/';
  static const userHomePage = '/user';
  static const topTabPage = '/top_tab';
  static const bottomTabPage = '/bottom_tab';
  static const formPage = '/form';
  static const loginPage = '/login';
  static const reduxPage = '/redux';
  static const configsPage = '/configs';
  static const configsUserPage = '/configs_user';
  static const isolatePage = '/isolate';

  static final detailsGlobalPage = <DetailsPage>[
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
    DetailsPage(
      name: 'BottomTab', 
      goToNamedRoute: bottomTabPage,
      leading: Icon(Icons.hail),
      transitionsPage: TransitionsPage(
        builder: (ctx) => BottomTabPage(),
        hasAnimation: false,
      ),
    ),
    DetailsPage(
      name: 'Form', 
      goToNamedRoute: formPage,
      leading: Icon(Icons.format_align_center_outlined),
      transitionsPage: TransitionsPage(
        builder: (ctx) => FormPage(),
      ),
    ),
    DetailsPage(
      name: 'Login', 
      goToNamedRoute: loginPage,
      leading: Icon(Icons.login),
      transitionsPage: TransitionsPage(
        builder: (ctx) => LoginPage(),
      ),
    ),
    DetailsPage(
      name: 'Redux', 
      goToNamedRoute: reduxPage,
      leading: Icon(Icons.redeem),
      transitionsPage: TransitionsPage(
        builder: (ctx) => ReduxPage(),
      ),
    ),
    DetailsPage(
      name: 'Configura????es', 
      goToNamedRoute: configsPage,
      leading: Icon(Icons.settings),
      transitionsPage: TransitionsPage(
        builder: (ctx) => ConfigPage(),
      ),
    ),
    DetailsPage(
      name: 'Isolate', 
      goToNamedRoute: isolatePage,
      leading: Icon(Icons.iso_outlined),
      transitionsPage: TransitionsPage(
        builder: (ctx) => IsolatePage(),
      ),
    ),
  ];

  static final detailsUserPage = <DetailsPage>[
    DetailsPage(
      name: 'userHomePage', 
      goToNamedRoute: userHomePage,
      leading: Icon(Icons.home),
      transitionsPage: TransitionsPage(
        builder: (ctx) => UserHomePage(),
        isUserPage: true,
      ),
    ),
    DetailsPage(
      name: 'Configura????es', 
      goToNamedRoute: configsUserPage,
      leading: Icon(Icons.settings),
      transitionsPage: TransitionsPage(
        builder: (ctx) => ConfigPage(isUserPage: true),
        isUserPage: true,
      ),
    ),
  ];

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    assert(
      settings.arguments == null || settings.arguments is TransitionsPage, 
      'Sempre passar como arguments de uma p??gina um TransitionsPage, sendo'
      ' que nele ?? poss??vel passar o argument e o que for necess??rio, al??m '
      'de ser poss??vel expand??-lo'
    );

    final TransitionsPage page = settings.arguments;
    final isUserPage = page?.isUserPage ?? true;
    CustomDrawer.changePage(settings.name, isUserPage ? detailsUserPage : detailsGlobalPage);
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