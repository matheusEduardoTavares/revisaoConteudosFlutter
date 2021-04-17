import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:projetocompleto2/redux/actions.dart';
import 'package:projetocompleto2/redux/app_state.dart';
import 'package:projetocompleto2/utils/images.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class HomeRedux extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador com Redux'),
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
          Column(
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
                      StoreConnector<AppState, int>(
                        converter: (store) => store.state.counter,
                        builder: (ctx, counter) => Text('Pessoas: $counter', style: TextStyle(color: Colors.white, fontSize: 30))
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('+1', style: TextStyle(color: Colors.white, fontSize: 30)),
                            onPressed: () {
                              StoreProvider.of<AppState>(context)
                                .dispatch(IncrementCounter());
                            },
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            child: Text('-1', style: TextStyle(color: Colors.white, fontSize: 30)),
                            onPressed: () {
                              StoreProvider.of<AppState>(context)
                                .dispatch(DecrementCounter());
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      StoreConnector<AppState, String>(
                        converter: (store) => store.state.message,
                        builder: (ctx, message) => Container(
                          child: Text(message, style: TextStyle(color: Colors.white, fontSize: 30)),
                        ),
                      ),
                    ],  
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}