import 'package:flutter/material.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class TopTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TopTab'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Tab 1'),
                icon: Icon(Icons.fire_extinguisher),
              ),
              Tab(
                child: Text('Tab 2'),
                icon: Icon(Icons.ondemand_video),
              ),
              Tab(
                child: Text('Tab 3'),
                icon: Icon(Icons.cached),
              ),
            ],
          ),
        ),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: [
            Center(
              child: Text('Aba 1'),
            ),
            Center(
              child: Text('Aba 2'),
            ),
            Center(
              child: Text('Aba 3'),
            ),
          ],
        ),
      ),
    );
  }
}