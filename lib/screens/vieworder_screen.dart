import 'package:eco_admin_panel/providers/order_provider.dart';
import 'package:eco_admin_panel/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewOrderScreen extends StatelessWidget {
  const ViewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Color.fromARGB(255, 22, 22, 22),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: orderProvider.fetchOrdersStream(),
        builder: (ctx, snapshot) {
          if (orderProvider.orders.isEmpty) {
            return const Center(
              child: Text('No order has been added'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (ctx, index) => OrderItemWidget(
                orderModel: orderProvider.orders.values.toList()[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
