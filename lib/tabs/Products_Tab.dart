import 'package:flutter/material.dart';
import 'package:loja/tiles/Categorie_Tiles.dart';

//class ProductsTab extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<QuerySnapshot>(
//      future: Firestore.instance.colletion("product").getDocuments,
//      builder: (context, snapshot){
//        if(!snapshot.hasData)
//        return Center(child: CircularProgressIndicator(),);
//
//        else {
//          var dividedTiles = ListTile.divideTiles(tiles: snapshot.data.documents.map(
//                  (doc){
//                return CategoriesTile(doc);
//              }
//          ).toList(),
//          color: Colors.grey[500]).toList();
//
//
//          return ListView(
//            children: dividedTiles
//          );
//        }
//      },
//    );
//  }
//}
