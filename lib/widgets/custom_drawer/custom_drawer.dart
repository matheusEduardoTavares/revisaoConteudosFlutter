import 'package:flutter/material.dart';
import 'package:projetocompleto2/models/details_page.dart';
import 'package:projetocompleto2/models/transitions_page.dart';
import 'package:projetocompleto2/pages/home_page/home_page.dart';
import 'package:projetocompleto2/utils/db_util.dart';
import 'package:projetocompleto2/utils/routes.dart';
import 'package:projetocompleto2/widgets/opacity_request/opacity_request.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    this.pages,
    this.hasLogoutButton = false,
  });

  final List<DetailsPage> pages;
  final bool hasLogoutButton;
  
  static int _selectedIndex = 0;


  static void changePage(String newPage, [List<DetailsPage> pages]) {
    final filterInPages = pages ?? Routes.detailsGlobalPage;

    var index = filterInPages.
      indexWhere((page) => page.goToNamedRoute == newPage);

    if (index != -1) {
      _selectedIndex = index;
    }
  }

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _itemsColor = Colors.red[50];

  var _isLoadingLogout = false;

  @override 
  Widget build(BuildContext context) {
    final pagesItems = widget.pages ?? Routes.detailsGlobalPage;

    return OpacityRequest(
      isLoading: _isLoadingLogout,
      child: Drawer(
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
                color: _itemsColor,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: pagesItems.length,
                  itemBuilder: (ctx, index) => Card(
                    elevation: 5.0,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      selected: CustomDrawer._selectedIndex == index,
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
            if (widget.hasLogoutButton ?? false)
              Container(
                color: _itemsColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoadingLogout = true;
                        });

                        await DbUtil.clearData();
                        
                        setState(() {
                          _isLoadingLogout = false;
                        });

                        Navigator.of(context).pushReplacementNamed(
                          Routes.homePage,
                          arguments: TransitionsPage(
                            builder: (ctx) => HomePage(false),
                          )
                        );
                      },
                      child: Text('Fazer Logout'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}