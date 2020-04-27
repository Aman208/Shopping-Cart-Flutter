import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shopping-cart-f6e08.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          totalAmount: orderData['totalAmount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          orderedProducts: (orderData['orderedProducts'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _items = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrders(double amount, List<CartItem> orderedProducts) async {
    const url = 'https://shopping-cart-f6e08.firebaseio.com/orders.json';

    try {
      DateTime timestamp = DateTime.now();
      var response = await http.post(url,
          body: json.encode({
            'totalAmount': amount,
            'dateTime': timestamp.toIso8601String(),
            'orderedProducts': orderedProducts
                .map((prod) => {
                      'id': prod.id,
                      'title': prod.title,
                      'price': prod.price,
                      'quantity': prod.quantity,
                    })
                .toList(),
          }));

      _items.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              totalAmount: amount,
              orderedProducts: orderedProducts,
              dateTime: DateTime.now()));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
