import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavorite == true).toList();
  }

  Product findItembyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> getProductsAndSet() async {
    const url = 'https://shopping-cart-f6e08.firebaseio.com/products.json';

    try {
      var response = await http.get(url);
      List<Product> loadedProducts = [];

      var extractedData = json.decode(response.body) as Map<String, dynamic>;

      extractedData.forEach((prodid, product) {
        loadedProducts.add(Product(
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite'],
            id: prodid));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://shopping-cart-f6e08.firebaseio.com/products.json';

    try {
      var response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://shopping-cart-f6e08.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);

    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }


  Future<void> updateProduct(String id, Product updatedProduct) async {
    
       var url = 'https://shopping-cart-f6e08.firebaseio.com/products/$id.json';
       
       try{
       await http.patch(url, body :  json.encode({
            'title': updatedProduct.title,
            'description': updatedProduct.description,
            'imageUrl':updatedProduct.imageUrl,
            'price': updatedProduct.price,
          }));
        
      var temp = _items.indexWhere((prod) => prod.id == id);

      if (temp >= 0)
        _items[temp] = updatedProduct;
      else {
        return;
      }
       }
       catch(error){
         throw error;
       }
    

    notifyListeners();
  }
}
