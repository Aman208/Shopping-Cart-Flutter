import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../screens/edit-product.dart';

class ManageProductsItem extends StatelessWidget {
  final String id;
  final String url;
  final String title;

  ManageProductsItem(this.id ,this.url, this.title);

  @override
  Widget build(BuildContext context) {
    print(title);
    return  ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(url),),
      title: Text(title),
       trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {Navigator.of(context).pushNamed(EditProduct.routeName , arguments: id);},
              color: Theme.of(context).primaryColor,
            ),
           
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () { Provider.of<ProductsProvider>(context, listen: false).deleteProduct(id);},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
    ));
  }
}
