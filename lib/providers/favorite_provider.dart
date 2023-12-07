import 'package:eco_admin_panel/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FavoriteProvider extends ChangeNotifier {
  Map<String, CartModel> favoriteMap = {};

  void addToFavorite({
    required String productId,
    required String title,
    required String image,
    required String price,
  }) {
    favoriteMap.putIfAbsent(
      productId,
      () => CartModel(
        productTitle: title,
        productImage: image,
        productPrice: price,
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  bool isExist({required String productId}) {
    return favoriteMap.containsKey(productId);
  }

  void clearFavorite() {
    favoriteMap.clear();
    notifyListeners();
  }

  void removeFavorite({required String productId}) {
    favoriteMap.remove(productId);
    notifyListeners();
  }
}
