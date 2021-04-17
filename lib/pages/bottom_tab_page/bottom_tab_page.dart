import 'package:flutter/material.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class BottomTabPage extends StatefulWidget {
  @override
  _BottomTabPageState createState() => _BottomTabPageState();
}

class _BottomTabPageState extends State<BottomTabPage> {
  var _selectedIndex = 0;

  final _bodyPerIndex = [
    Center(
      child: Text('Aba 1')
    ),
    Center(
      child: Text('Aba 2')
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomTabPage'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.integration_instructions),
            label: 'BottomNavigationBarItem 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'BottomNavigationBarItem 2',
          ),
        ],
      ),
      body: _bodyPerIndex[_selectedIndex],
    );
  }
}