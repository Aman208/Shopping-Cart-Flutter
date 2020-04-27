import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

import 'package:shopping_cart/screens/cart_screen.dart';
import 'package:shopping_cart/widgets/app_drawer.dart';

import '../widgets/product_gridView.dart';
import '../widgets/badge.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isfavScreen = false;
  bool isInit = true;
  bool isLoading = false;
  @override
  void initState() {
      

    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (isInit) {
      try {
        setState(() {
      isLoading = true;
    });
    await Provider.of<ProductsProvider>(context, listen: false)
            .getProductsAndSet();

     setState(() {
      isLoading = false;
    });        
      } catch (error) {
        print(error);
      }
    }
    isInit = false ;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            Badge(
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CartScreen.routeName, arguments: []);
                  }),
            ),
            PopupMenuButton(
              child: Icon(Icons.more_vert),
              onSelected: (int value) {
                setState(() {
                  if (value == 0) {
                    _isfavScreen = false;
                  } else {
                    _isfavScreen = true;
                  }
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Show Favourite"),
                ),
                PopupMenuItem(
                  value: 0,
                  child: Text("Show All"),
                ),
              ],
            )
          ],
        ),
        drawer: AppDrawer(),
        body: isLoading ? Center(child: CircularProgressIndicator(),) : ProductGridView(_isfavScreen));
  }
}
