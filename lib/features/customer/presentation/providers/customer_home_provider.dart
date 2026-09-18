import 'package:flutter/material.dart';
import 'package:delivery_app/features/customer/data/models/customer_models.dart';

class CustomerHomeProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  final List<CategoryModel> categories = [
    CategoryModel(id: '0', nameKey: 'all', icon: Icons.grid_view_rounded),
    CategoryModel(id: '1', nameKey: 'restaurants', icon: Icons.restaurant),
    CategoryModel(id: '2', nameKey: 'supermarkets', icon: Icons.local_grocery_store),
    CategoryModel(id: '3', nameKey: 'pharmacies', icon: Icons.local_pharmacy),
    CategoryModel(id: '4', nameKey: 'electronics', icon: Icons.devices),
  ];

  final List<StoreModel> featuredStores = [
    StoreModel(
      id: 's1',
      name: 'مطعم الأصالة والذوق',
      rating: 4.8,
      deliveryTime: '20-30',
      deliveryFee: 500.0,
      categoryKey: 'restaurants',
    ),
    StoreModel(
      id: 's2',
      name: 'سوبرماركت الخيرات',
      rating: 4.6,
      deliveryTime: '15-25',
      deliveryFee: 300.0,
      categoryKey: 'supermarkets',
    ),
  ];

  final List<ProductModel> popularProducts = [
    ProductModel(
      id: 'p1',
      name: 'وجبة غداء عائلية',
      price: 4500,
      storeName: 'مطعم الأصالة',
      rating: 4.9,
    ),
    ProductModel(
      id: 'p2',
      name: 'عصير برتقال طازج 1L',
      price: 1200,
      storeName: 'سوبرماركت الخيرات',
      rating: 4.7,
    ),
  ];
}
