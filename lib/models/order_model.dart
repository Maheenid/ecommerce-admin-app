class OrderModel {
  final String orderId, orderTitle, orderPrice, orderImage;
  final int orderQuantity;

  OrderModel({
    required this.orderId,
    required this.orderTitle,
    required this.orderPrice,
    required this.orderImage,
    required this.orderQuantity,
  });
}
