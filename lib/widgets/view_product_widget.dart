import 'package:eco_admin_panel/models/product_model.dart';
import 'package:eco_admin_panel/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';

class ViewProductWidget extends StatelessWidget {
  const ViewProductWidget({super.key, this.productModel});
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    if (productModel == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (ctx)=>EditProductScreen(productModel: productModel) ),);},
      child: Column(
        children: [
          Image.network(
            productModel!.productImage,
            width: 130,
            height: 120,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: SizedBox(
              width: 130,
              child: Text(
                '${productModel!.productTitle}...',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              '\$${productModel!.productPrice}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
