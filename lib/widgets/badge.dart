import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';


class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,

    this.color,
  }) : super(key: key);

  final Widget child;
 
  final Color color;

  @override
  Widget build(BuildContext context) {
    Provider.of<Cart>(context , listen: false);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Consumer<Cart>(builder:  (ctx , cart , child) => Text(
              cart.getCount.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black
              ),
            ),)
          ),
        )
      ],
    );
  }
}