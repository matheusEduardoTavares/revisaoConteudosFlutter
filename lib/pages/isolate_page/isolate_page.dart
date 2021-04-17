import 'package:flutter/material.dart';
import 'package:projetocompleto2/custom_isolate/custom_isolate.dart';
import 'package:projetocompleto2/utils/images.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class IsolatePage extends StatefulWidget {
  @override
  _IsolatePageState createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  final _isolate = CustomIsolate();

  var _counter = 0;

  Widget _createMessage(int value) {
    String message;
    if (value > 10) {
      message = 'Lotado!';
    }
    else if (value >= 0) {
      message = 'Pode Entrar!';
    }
    
    message ??= 'Mundo Alternativo!';

    return Text(message, style: TextStyle(color: Colors.white, fontSize: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador com Isolate'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Image.asset(
            Images.restaurantImage,
            fit: BoxFit.cover,
            height: 1000.0,
          ),
          StreamBuilder(
            stream: _isolate.externalPort,
            initialData: 0,
            builder: (ctx, snapshot) {
              _counter = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Column(
                        children: [
                          Text('Pessoas: $_counter', style: TextStyle(color: Colors.white, fontSize: 30)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                child: Text('+1', style: TextStyle(color: Colors.white, fontSize: 30)),
                                onPressed: () {
                                  _isolate.incrementCounter(_counter);
                                },
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                child: Text('-1', style: TextStyle(color: Colors.white, fontSize: 30)),
                                onPressed: () {
                                  _isolate.decrementCounter(_counter);
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          _createMessage(_counter)
                        ],  
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}