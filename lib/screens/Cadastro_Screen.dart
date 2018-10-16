import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja/models/Users_Model.dart';
import 'package:scoped_model/scoped_model.dart';


class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKet = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {

          if(model.isLoading)

            return Center(child: CircularProgressIndicator(),);

          return Form(
              key: _formKet,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration:
                    InputDecoration.collapsed(hintText: "Nome Completo"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome Inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration.collapsed(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail Inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration.collapsed(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Invalida";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _adressController,
                    decoration: InputDecoration.collapsed(hintText: "Endereço"),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço Invalido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKet.currentState.validate()) {

                            Map<String, dynamic> userData = {
                              "name": _nameController,
                              "email": _emailController,
                              "address": _adressController
                            };

                            model.singUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );
                          }
                        },
                        child: Text(
                          "Criar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              )
          );
        }
        )
    );
  }
  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso !!!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then(((_){
      Navigator.of(context).pop();
    }));
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar o Usuário!!!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
