import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart' as owd;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static final routeName = '/order-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<owd.Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<owd.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ))
          : ListView.builder(
              itemCount: orderData.itemsCount,
              itemBuilder: (ctx, i) => OrderItem(orderData.items[i])),
      drawer: AppDrawer(),
    );
  }
}
