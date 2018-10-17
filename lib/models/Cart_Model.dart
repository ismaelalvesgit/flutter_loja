import 'package:flutter/material.dart';
import 'package:loja/datas/Cart_Product.dart';
import 'package:loja/models/Users_Model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel extends Model{

  UserModel user;

  List<CartProduct> product = [];

  String couponCode;
  int discountPercentage;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn()){
      _loadCartItens();
    }
  }

  static CartModel of (BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    product.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").add(cartProduct.toMap()).then((doc){
         cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).delete();
    product.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity --;
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity ++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercent){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercent;
  }

  void _loadCartItens() async{
     QuerySnapshot query  =  await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();
     
     product = query.documents.map((doc)=>CartProduct.fromDocument(doc)).toList();
     notifyListeners();
  }
}