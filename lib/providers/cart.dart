import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get getCount{
    return _items.length;
  }

  String get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total.toStringAsFixed(2);
  }

  void removeItem(String productId){
     _items.remove(productId);

    notifyListeners();
  }

  void addToCart(String id, double price, String title) {
 

    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity+1));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }

    notifyListeners();
  }

   void clearCart(){
     _items ={};

     notifyListeners();

   }

}
