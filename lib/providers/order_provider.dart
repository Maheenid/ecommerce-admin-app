import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_admin_panel/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  Map orders = {};
  final userOrder = FirebaseFirestore.instance.collection("allOrders");

  Stream fetchOrdersStream() {
    try {
      return userOrder.snapshots().map((snapshot) {
        orders.clear();
        for (final data in snapshot.docs) {
          orders.putIfAbsent(
            data.get("orderId"),
            () => OrderModel(
              orderId: data.get("orderId"),
              orderTitle: data.get("orderTitle"),
              orderPrice: data.get("orderPrice"),
              orderImage: data.get("orderImage"),
              orderQuantity: data.get("qty"),
            ),
          );
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeCartItemFromFirebase({
    required orderId,
    required BuildContext context,
  }) async {
    try {
      userOrder.doc(orderId).delete();
      orders.remove(orderId);
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}
