import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/screens/edit-product.dart';
import 'package:shopping_cart/screens/manage-products-screen.dart';
import 'package:shopping_cart/screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
         ChangeNotifierProvider.value(
          value: Cart(),
        ),
         ChangeNotifierProvider.value(
          value: Orders(),
        ),
        

      ],
      child: MaterialApp(
          title: 'Shopping Cart',
          theme:
              ThemeData(primarySwatch: Colors.blue, accentColor: Colors.yellow ,fontFamily: 'Lato',),

          home: ProductsOverviewScreen(),
          
          
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName :(ctx) => CartScreen() ,
            OrdersScreen.routeName : (ctx) => OrdersScreen() ,
            ManageProductsScreen.routeName : (ctx) => ManageProductsScreen(),
            EditProduct.routeName : (ctx) => EditProduct() ,
          }),
    );
  }
}
