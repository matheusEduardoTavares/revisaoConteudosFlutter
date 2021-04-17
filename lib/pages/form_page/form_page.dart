import 'package:flutter/material.dart';
import 'package:projetocompleto2/widgets/custom_drawer/custom_drawer.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _items = <double>[];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  FocusNode _itemFocus;

  @override 
  void initState() {
    super.initState();

    _itemFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('FormPage'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _items.isEmpty ? Expanded(child: Center(child: Text('Nenhum item foi adicionado !'))) :
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: Text('$index.'),
                  title: Text('Item: ${_items[index]}'),
                ),
              ),
            ),
          if (_items.isNotEmpty)
            const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: TextFormField(
                      controller: _itemController,
                      focusNode: _itemFocus,
                      decoration: InputDecoration(
                        labelText: 'Insira um número',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty || double.tryParse(value) == null) {
                          return 'Digite um número';
                        }

                        return null;
                      }
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Adicionar'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _items.add(double.parse(_itemController.text));
                      _itemFocus?.unfocus();
                    }
                    else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text('Erro no valor digitado'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () async {
                              final valueForTest = 5;
                              final test = await showDialog(
                                context: context,
                                builder: (ctx) => Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                                    AlertDialog(
                                      title: Text('Confirmado o SnackBar'),
                                      content: Text('Usuário já sabe do erro'),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop(valueForTest);
                                          }
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );

                              print('test = $test');
                            }
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override 
  void dispose() {
    _itemFocus?.dispose();

    super.dispose();
  }
}