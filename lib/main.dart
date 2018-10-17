import 'package:flutter/material.dart';
import 'package:loja/models/Cart_Model.dart';
import 'package:loja/models/Users_Model.dart';
import 'package:loja/screens/Home_Screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant <UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model),
          child: MaterialApp(
            title: 'Flutter Clothing',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 4, 125, 141)),
            home: HomeScreen(),
            debugShowCheckedModeBanner: false,
            ),
          );
        }
      )
    );
  }
}
