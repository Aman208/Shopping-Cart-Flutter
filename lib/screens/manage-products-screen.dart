import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/widgets/app_drawer.dart';
import 'package:shopping_cart/widgets/manage-products-item.dart';
import '../providers/products_provider.dart';

class ManageProductsScreen extends StatelessWidget {
  static String routeName = '/mangage-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: (){})],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ManageProductsItem(productData.items[index].imageUrl,
                        productData.items[index].title),
                     Divider(),
                  ],
                ),
            itemCount: productData.items.length),
      ),
    );
  }
}
