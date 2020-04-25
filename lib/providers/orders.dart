import 'package:flutter/foundation.dart';
import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> orderedProducts;
  final DateTime dateTime;

  OrderItem({this.id, this.totalAmount, this.orderedProducts, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrders(double amount, List<CartItem> orderedProducts) {
    print(_items.length);
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            totalAmount: amount,
            orderedProducts: orderedProducts,
            dateTime: DateTime.now()));
            notifyListeners();
  }

  int get itemsCount  {
       return _items.length;
  }
  




}
