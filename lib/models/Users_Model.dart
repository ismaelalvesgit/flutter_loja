import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Model{

    final FirebaseAuth _auth = FirebaseAuth.instance;

     FirebaseUser firebaseUser;

    bool isLoading = false;

    Map<String, dynamic> userData = Map();


    void singUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail }) async{
      isLoading = true;
      notifyListeners();

      _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then((user) async{
        firebaseUser = user;

        await _saveUserData(userData);

        onSuccess();
        isLoading = false;
        notifyListeners();
      }).catchError((e){
        onFail();
        isLoading = false;
        notifyListeners();
      });

    }

    void singIn(String email, String pass) async{
      isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 3));
      _auth.signInWithEmailAndPassword(email:email , password: pass);
    }

    void singOut() async{
      await _auth.signOut();
      userData = Map();
      firebaseUser = null;
      notifyListeners();
    }

    void recoverPass(){

    }

    bool isLoggedIn(){
      return firebaseUser != null;
    }

    Future<Null>_saveUserData(Map<String, dynamic> userData) async{
        this.userData = userData;
        await Firestore.instance.collection(("users")).document(firebaseUser.uid).setData(userData);
    }
}