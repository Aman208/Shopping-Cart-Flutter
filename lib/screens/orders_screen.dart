import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';

 import '../providers/orders.dart' as owd;
 import '../widgets/order_item.dart' ;


class OrdersScreen extends StatelessWidget {

   static final routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<owd.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.itemsCount ,
        itemBuilder: (ctx, i) => OrderItem(orderData.items[i])
      ),
    );
  }
}