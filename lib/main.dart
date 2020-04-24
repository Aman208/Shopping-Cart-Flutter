import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
          value:  new ProductsProvider(),
          child: MaterialApp(
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber

        ),
        home: ProductsOverviewScreen() ,
        routes : {
          ProductDetailScreen.routeName : (ctx) => ProductDetailScreen() ,
        }

      ),
    );
  }
}

