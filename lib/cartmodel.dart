import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<Food> cart = [];
  double totalCartValue = 0;

  int get total => cart.length;

  dynamic data;
  void addProduct(data) {
    int index = cart.indexWhere((i) => i.Id == data['id']);
    print(index);
    if (index != -1)
      updateProduct(cart[index], cart[index].qty + 1);
    else {
      Food food = new Food();
      food.Id = data['id'];
      food.Name = data['text'].toString();
      food.SalesRate = data['salesRate'];
      food.CategoryId = data['categoryId'];
      food.qty = 1;

      cart.add(food);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.Id == product.Id);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.Id == product.Id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.Id == product.Id);
    cart[index].qty = qty;
    if (cart[index].qty == 0) removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.SalesRate * f.qty;
    });
  }
}

class Food {
  // ignore: non_constant_identifier_names
  dynamic Id;
  // ignore: non_constant_identifier_names
  String Name;
  // ignore: non_constant_identifier_names
  dynamic SalesRate;
  // ignore: non_constant_identifier_names
  dynamic CategoryId;

  dynamic qty;

  // ignore: non_constant_identifier_names
  Food({this.Id, this.Name, this.SalesRate, this.CategoryId, this.qty});

  Food.fromJson(Map<dynamic, dynamic> json) {
    Id = json['Id'];
    Name = json['UserName'];
    SalesRate = json['SalesRate'];
    CategoryId = json['CategoryId'];
    qty = json['qty'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['Id'] = this.Id;
    data['UserName'] = this.Name;
    data['SalesRate'] = this.SalesRate;
    data['CategoryId'] = this.CategoryId;
    data['qty'] = this.qty;

    return data;
  }

  // Map<String, dynamic> myMap = new Map<String, dynamic>.from(

  // );

}
