import 'package:flutter/material.dart';
import 'package:projetocompleto2/utils/routes.dart';

class CustomDrawer extends StatelessWidget {
  static int _selectedIndex = 0;

  @override 
  Widget build(BuildContext context) {
    final pagesItems = Routes.detailsPage;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'Aplicativo de estudos', 
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                shadows: [
                  Shadow(
                    blurRadius: 0.8,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: pagesItems.length,
              itemBuilder: (ctx, index) => Card(
                elevation: 5.0,
                shadowColor: Colors.grey,
                child: ListTile(
                  selected: _selectedIndex == index,
                  leading: pagesItems[index].leading,
                  title: pagesItems[index].title ?? Text(pagesItems[index].name),
                  onTap: () {
                    _selectedIndex = index;
                    Navigator.of(context).pushReplacementNamed(
                      pagesItems[index].goToNamedRoute,
                      arguments: pagesItems[index].transitionsPage,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}