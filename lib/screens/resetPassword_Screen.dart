import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja/models/Users_Model.dart';
import 'package:scoped_model/scoped_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Recupere sua Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context , child, model){
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
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
                    SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                                model.recoverPass(email: _emailController.text, onSuccess: _onSuccess, onFail: _onFail);
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
      ),
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Confira seu email ${_emailController.text} !!!"),
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
        SnackBar(content: Text("Falha ao fazer o envio!!!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
