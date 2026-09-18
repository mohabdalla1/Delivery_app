enum MerchantOrderStatus { newOrder, preparing, ready, completed, canceled }

class MerchantProductModel {
  final String id;
  String name;
  double price;
  String category;
  bool isAvailable;
  String description;

  MerchantProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.isAvailable = true,
    this.description = '',
  });
}

class MerchantOrderItemModel {
  final String productName;
  final int quantity;
  final double price;

  MerchantOrderItemModel({
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => price * quantity;
}

class MerchantOrderModel {
  final String orderId;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final List<MerchantOrderItemModel> items;
  final double totalAmount;
  final DateTime orderTime;
  MerchantOrderStatus status;
  final String? customerNote;

  MerchantOrderModel({
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    required this.totalAmount,
    required this.orderTime,
    this.status = MerchantOrderStatus.newOrder,
    this.customerNote,
  });
}
