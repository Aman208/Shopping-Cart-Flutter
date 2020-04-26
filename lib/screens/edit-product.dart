
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String routeName = '/edit-product';

  @override
  _EditProductState createState() => _EditProductState();
}

final _priceFocusNode = FocusNode();
final _descriptionFocusNode = FocusNode();

@override
void dispose() {
  _priceFocusNode.dispose();
  _descriptionFocusNode.dispose();
  //  super.dispose();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Product")),
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              child: ListView(children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Title'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Price'),
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                ) ,

              ]),
            )));
  }
}
