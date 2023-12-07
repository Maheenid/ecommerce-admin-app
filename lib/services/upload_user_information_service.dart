import 'package:cloud_firestore/cloud_firestore.dart';

class UploadProduct {
  uploadProduct({
    required productId,
    required productTitle,
    required productPrice,
    required productCategory,
    required productDescription,
    required productImage,
    required productQuantity,
  }) async {
    await FirebaseFirestore.instance.collection("products").doc(productId).set({
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productDescription': productDescription,
      'productImage': productImage,
      'productQuantity': productQuantity,
    });
  }
}
