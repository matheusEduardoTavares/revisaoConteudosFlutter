import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projetocompleto2/widgets/positioned_button_to_home_page/positioned_button_to_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  TextEditingController _nameController;
  TextEditingController _passwordController;
  FocusNode _nameFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  final _defaultDuration = const Duration(milliseconds: 300);

  AnimationController _controller;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  final _minHeight = 254.0;
  final _maxHeight = 354.0;

  @override 
  void initState() {
    super.initState();
    _nameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    
    _nameController = TextEditingController();
    _passwordController = TextEditingController();

    _controller = AnimationController(
      vsync: this,
      duration: _defaultDuration,
    );

    _heightAnimation = Tween<Size>(
      begin: Size(double.infinity, _minHeight),
      end: Size(double.infinity, _maxHeight)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    ///Usando o [AnimatedContainer] e não o 
    ///[AnimatedBuilder] não precisa do 
    ///[addListener] para dar um [setState]
    // _heightAnimation.addListener(() {
    //   setState(() {});
    // });

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.5),
      end: Offset(0.0, 0.0)
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _text = _isLogin ? 'Fazer Login' : 'Criar Conta';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.purpleAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 8,
                        ),
                        child: Text(_text, style: TextStyle(fontSize: 40, color: Colors.white)),
                        transform: Matrix4.rotationZ(-8 * pi / 180),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 5.0,
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 8.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LayoutBuilder(
                                  builder: (ctx, constraints) => AnimatedContainer(
                                  height: _isLogin ? _minHeight : _maxHeight,
                                  duration: _defaultDuration,
                                  curve: Curves.ease,
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        focusNode: _nameFocus,
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Nome'
                                        ),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Digite um nome';
                                          }
                                          else if (value.length < 4) {
                                            return 'Digite pelo menos 4 caracteres';
                                          }

                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        focusNode: _passwordFocus,
                                        controller: _passwordController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          labelText: 'Senha'
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Digite uma senha';
                                          }
                                          else if (value.length < 7) {
                                            return 'Digite pelo menos 7 caracteres';
                                          }

                                          return null;
                                        },
                                      ),
                                      AnimatedContainer(
                                        height: _isLogin ? 0 : 100.0,
                                        duration: _defaultDuration,
                                        curve: Curves.ease,
                                        child: SlideTransition(
                                          position: _slideAnimation,
                                          child: FadeTransition(
                                            opacity: _opacityAnimation,
                                            child: TextFormField(
                                              focusNode: _confirmPasswordFocus,
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              decoration: InputDecoration(
                                                labelText: 'Confirmar a senha'
                                              ),
                                              validator: !_isLogin ? (value) {
                                                if (value != _passwordController.value.text) {
                                                  return 'Senhas diferentes';
                                                }

                                                return null;
                                              } : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        child: Text(_text),
                                        onPressed: () {
                                          print('_isLogin = $_isLogin');
                                          print('ElevatedButton');
                                        },
                                      ),
                                      TextButton(
                                        child: Text(_isLogin ? 'Mudar para criação de conta' : 'Mudar para fazer login'),
                                        onPressed: () {
                                          setState(() {
                                            _isLogin = !_isLogin;
                                            if (_isLogin) {
                                              _controller.reverse();
                                            }
                                            else {
                                              _controller.forward();
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PositionedButtonToHomePage()
        ],
      ),
    );
  }

  @override 
  void dispose() {
    _nameController?.dispose();
    _passwordController?.dispose();

    _nameFocus?.dispose();
    _passwordFocus?.dispose();
    _confirmPasswordFocus?.dispose();

    _controller?.dispose();

    super.dispose();
  }
}