import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../screens/orders_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context , listen: false);
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Consumer<Cart>(builder: (_ , cart , child) => Chip(
                    label: Text(
                      '\$ ${cart.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),) ,
                  
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      orders.addOrders(double.parse(cart.totalAmount), cart.items.values.toList(), );
                      cart.clearCart();
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
