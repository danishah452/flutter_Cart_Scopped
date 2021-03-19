import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'cartmodel.dart';
import 'cartpage.dart';
import 'home.dart';

void main() => runApp(MyApp(
    model: CartModel(),
  ));


class MyApp extends StatelessWidget{

  final CartModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<CartModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        home: HomePage(),
        routes: {'/cart': (context) => CartPage()},
      ),
    );
  }
}