import 'package:flutter/material.dart';
import '../screens/edit-product.dart';

class ManageProductsItem extends StatelessWidget {
  final String url;
  final String title;

  ManageProductsItem(this.url, this.title);

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
              onPressed: () {Navigator.of(context).pushNamed(EditProduct.routeName);},
              color: Theme.of(context).primaryColor,
            ),
           
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
    ));
  }
}
