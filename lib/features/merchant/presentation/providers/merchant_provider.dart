import 'package:flutter/material.dart';
import 'package:delivery_app/features/merchant/data/models/merchant_models.dart';

class MerchantProvider extends ChangeNotifier {
  bool _isStoreOpen = true;
  bool get isStoreOpen => _isStoreOpen;

  void toggleStoreStatus() {
    _isStoreOpen = !_isStoreOpen;
    notifyListeners();
  }

  final List<MerchantProductModel> _products = [
    MerchantProductModel(
      id: 'mp1',
      name: 'وجبة غداء عائلية',
      price: 4500,
      category: 'مطاعم',
      isAvailable: true,
      description: 'وجبة تكفي 4 أشخاص مع مقبلات ومشروبات.',
    ),
    MerchantProductModel(
      id: 'mp2',
      name: 'ساندويتش برجر كلاسيك',
      price: 1800,
      category: 'وجبات سريعة',
      isAvailable: true,
      description: 'لحم بقر طازج مع الجبن والصوص الخاص.',
    ),
    MerchantProductModel(
      id: 'mp3',
      name: 'بيتزا سوبر بريم',
      price: 3200,
      category: 'معجنات',
      isAvailable: false,
      description: 'بيتزا مشكلة مع الجبن والزيوتون والبتيروني.',
    ),
  ];

  List<MerchantProductModel> get products => List.unmodifiable(_products);

  final List<MerchantOrderModel> _orders = [
    MerchantOrderModel(
      orderId: '1042',
      customerName: 'أحمد مصطفى',
      customerPhone: '0912345678',
      deliveryAddress: 'الخرطوم - حي المطار',
      items: [
        MerchantOrderItemModel(productName: 'وجبة غداء عائلية', quantity: 1, price: 4500),
      ],
      totalAmount: 4500,
      orderTime: DateTime.now().subtract(const Duration(minutes: 10)),
      status: MerchantOrderStatus.newOrder,
      customerNote: 'يرجى تقليل الفلفل الحار',
    ),
    MerchantOrderModel(
      orderId: '1041',
      customerName: 'سارة محمد',
      customerPhone: '0998765432',
      deliveryAddress: 'أمبدة - الحارة 12',
      items: [
        MerchantOrderItemModel(productName: 'ساندويتش برجر كلاسيك', quantity: 2, price: 1800),
      ],
      totalAmount: 3600,
      orderTime: DateTime.now().subtract(const Duration(minutes: 25)),
      status: MerchantOrderStatus.preparing,
    ),
  ];

  List<MerchantOrderModel> get orders => List.unmodifiable(_orders);

  double get todaySales => _orders
      .where((o) => o.status != MerchantOrderStatus.canceled)
      .fold(0.0, (sum, o) => sum + o.totalAmount);

  int get todayOrdersCount => _orders.length;

  void toggleProductAvailability(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index >= 0) {
      _products[index].isAvailable = !_products[index].isAvailable;
      notifyListeners();
    }
  }

  void addProduct(MerchantProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(MerchantProductModel product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, MerchantOrderStatus newStatus) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index >= 0) {
      _orders[index].status = newStatus;
      notifyListeners();
    }
  }
}
