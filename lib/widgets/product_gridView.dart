import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/products_provider.dart';

class ProductGridView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of< ProductsProvider >(context);
    final loadedProducts = productData.items;
    return Container(
      child : GridView.builder(
        
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                   value : loadedProducts[i] ,
                  child: ProductItem(
                // loadedProducts[i].id,
                // loadedProducts[i].title,
                // loadedProducts[i].imageUrl,
              ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
      
    );
  }
}