import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var _currentAppState = 'Sem informações';

  @override 
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override 
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final stateInText = state.toString();

    setState(() {
      _currentAppState = stateInText.substring(stateInText.indexOf('.') + 1);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(_currentAppState, style: TextStyle(fontSize: 40, color: Colors.red))
      ),
    );
  }

  @override 
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}