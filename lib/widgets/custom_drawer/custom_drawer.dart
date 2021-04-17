import 'package:flutter/material.dart';
import 'package:projetocompleto2/utils/routes.dart';

class CustomDrawer extends StatelessWidget {
  static int _selectedIndex = 0;

  static void changePage(String newPage) {
    var index = Routes.detailsPage.
      indexWhere((page) => page.goToNamedRoute == newPage);

    if (index != -1) {
      _selectedIndex = index;
    }
  }

  @override 
  Widget build(BuildContext context) {
    final pagesItems = Routes.detailsPage;

    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.purple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: DrawerHeader(
              child: Text(
                'Aplicativo de estudo', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.redAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 3.0,
                      offset: Offset(0, -3),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.purple,
                  blurRadius: 3.0,
                ),
              ],
            ),
            height: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.red[50],
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: pagesItems.length,
                itemBuilder: (ctx, index) => Card(
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: ListTile(
                    selected: _selectedIndex == index,
                    leading: pagesItems[index].leading,
                    title: pagesItems[index].title ?? Text(pagesItems[index].name),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        pagesItems[index].goToNamedRoute,
                        arguments: pagesItems[index].transitionsPage,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}