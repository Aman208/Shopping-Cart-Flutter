import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static String routeName = '/edit-product';

  @override
  _EditProductState createState() => _EditProductState();
}



class _EditProductState extends State<EditProduct> {

 final _priceFocusNode = FocusNode();
final _descriptionFocusNode = FocusNode();
final _imageFocusNode = FocusNode();
final _imageTextController = TextEditingController();


 void initState(){
  
  _imageFocusNode.addListener(updateImage);

   super.initState();
 }

@override
void dispose() {
  _imageFocusNode.removeListener(updateImage);
  _priceFocusNode.dispose();
  _descriptionFocusNode.dispose();
  _imageFocusNode.dispose();
  _imageTextController.dispose();
   super.dispose();
}

void updateImage(){
 
 if(!_imageFocusNode.hasFocus)
   {
     setState((){});
   }

}



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
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                      child: _imageTextController.text.isEmpty
                        ? Text('Enter a URL')
                        : Image.network(_imageTextController.text),
                    ),
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(labelText: 'Image Url'),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageFocusNode,
                      controller: _imageTextController,
                    ))
                  ],
                )
              ]),
            )));
  }
}
