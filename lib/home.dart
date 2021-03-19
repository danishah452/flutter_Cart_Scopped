import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cartmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Product> _products = [
  //   Product(
  //       id: 1,
  //       title: "Apple",
  //       price: 20.0,
  //       imgUrl: "https://img.icons8.com/plasticine/2x/apple.png",
  //       qty: 1),
  //   Product(
  //       id: 2,
  //       title: "Banana",
  //       price: 40.0,
  //       imgUrl: "https://img.icons8.com/cotton/2x/banana.png",
  //       qty: 1),
  //   Product(
  //       id: 3,
  //       title: "Orange",
  //       price: 20.0,
  //       imgUrl: "https://img.icons8.com/cotton/2x/orange.png",
  //       qty: 1),
  //   Product(
  //       id: 4,
  //       title: "Melon",
  //       price: 40.0,
  //       imgUrl: "https://img.icons8.com/cotton/2x/watermelon.png",
  //       qty: 1),
  //   Product(
  //       id: 5,
  //       title: "Avocado",
  //       price: 25.0,
  //       imgUrl: "https://img.icons8.com/cotton/2x/avocado.png",
  //       qty: 1),
  // ];

  final String appetizersURL =
      "http://95.168.178.230:99/Inventory/Api/GetAllAppetizers";
  List data;

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    this.getJsonData();
  }

  // ignore: missing_return
  Future<String> getJsonData() async {
    var response = await http.get(
        // Encoding URL
        Uri.encodeFull(appetizersURL),
        headers: {"Accept": "application/json"});

    print(response.body);

    this.setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          )
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: data == null ? 0 : data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/appetizers.jpg', width: 120, height: 120),
                  Text(
                    data[index]['text'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("\$" + data[index]['salesRate'].toString()),
                  OutlineButton(
                      child: new Text("Add"),
                      onPressed: () => model.addProduct(data[index]))
                ],
              ),
            );
          });
        },
      ),

      // ListView.builder(
      //   itemExtent: 80,
      //   itemCount: _products.length,
      //   itemBuilder: (context, index) {
      //     return ScopedModelDescendant<CartModel>(
      //         builder: (context, child, model) {
      //       return ListTile(
      //           leading: Image.network(_products[index].imgUrl),
      //           title: Text(_products[index].title),
      //           subtitle: Text("\$"+_products[index].price.toString()),
      //           trailing: OutlineButton(
      //               child: Text("Add"),
      //               onPressed: () => model.addProduct(_products[index])));
      //     });
      //   },
      // ),
    );
  }
}
