import 'package:flutter/material.dart';
import 'package:loja/models/Cart_Model.dart';
import 'package:loja/models/Users_Model.dart';
import 'package:loja/screens/Login_Screen.dart';
import 'package:loja/tiles/Cart_Tiles.dart';
import 'package:loja/widgets/Discount_Card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.product.length;
              return Text(
                "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                style: TextStyle(fontSize: 17.0),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return Center(child: CircularProgressIndicator());
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para adicionar os produtos",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>LoginScreen())
                    );
                  },
                  child: Text("Entrar", style: TextStyle(fontSize: 18.0)),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          );
        }else if (model.product ==null || model.product.length ==0){
          return Center(
            child: Text("Nenhum produto no carrinho!!!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
          );
        }else{
          return ListView(
            children: <Widget>[
              Column(

                children: model.product.map(
                  (product){
                    return CartTile(product);
                  }
                ).toList(),
              ),
              DiscountCard()
            ],
          );
        }
      }),
    );
  }
}
