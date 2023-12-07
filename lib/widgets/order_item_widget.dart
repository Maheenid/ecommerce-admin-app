import 'package:eco_admin_panel/models/order_model.dart';
import 'package:eco_admin_panel/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({
    super.key,
    required this.orderModel,
  });
  final OrderModel? orderModel;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidget();
}

class _OrderItemWidget extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    if (widget.orderModel == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.orderModel!.orderImage,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderModel!.orderTitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$${widget.orderModel!.orderPrice}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Qty',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.orderModel!.orderQuantity.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              orderProvider.removeCartItemFromFirebase(
                                orderId: widget.orderModel!.orderId,
                                context: context,
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
