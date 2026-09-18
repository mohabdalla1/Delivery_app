import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations(const Locale('ar'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'dashboard_title': 'لوحة تحكم المنصة',
      'system_name': 'نظام إدارة التوصيل',
      'home': 'الرئيسية',
      'merchants': 'المتاجر والتجار',
      'drivers': 'السائقين',
      'orders': 'الطلبات',
      'customers': 'العملاء',
      'total_orders': 'إجمالي الطلبات',
      'active_merchants': 'المتاجر النشطة',
      'available_drivers': 'السائقين المتاحين',
      'total_sales': 'إجمالي المبيعات',
      'switch_lang': 'English',
      'store_demo': 'متجر التجربة',
      'category_restaurants': 'التصنيف: مطاعم • الحالة: نشط',
      'driver_demo': 'السائق',
      'vehicle_bike': 'المركبة: دراجة نارية • الحالة: نشط',
      'available': 'متاح',
      'order_num': 'طلب رقم #',
      'store_name': 'المتاجر: مطعم البركة',
      'total': 'الإجمالي: \$',
      'delivering': 'قيد التوصيل',
      'completed': 'مكتمل',
      'processing': 'قيد المعالجة',
      'canceled': 'ملغى',
      'phone': 'الهاتف',
      'orders_count': 'عدد الطلبات',
    },
    'en': {
      'dashboard_title': 'Platform Dashboard',
      'system_name': 'Delivery Management System',
      'home': 'Home',
      'merchants': 'Merchants & Stores',
      'drivers': 'Drivers',
      'orders': 'Orders',
      'customers': 'Customers',
      'total_orders': 'Total Orders',
      'active_merchants': 'Active Merchants',
      'available_drivers': 'Available Drivers',
      'total_sales': 'Total Sales',
      'switch_lang': 'العربية',
      'store_demo': 'Demo Store',
      'category_restaurants': 'Category: Restaurants • Status: Active',
      'driver_demo': 'Driver',
      'vehicle_bike': 'Vehicle: Motorcycle • Status: Active',
      'available': 'Available',
      'order_num': 'Order #',
      'store_name': 'Store: Al Baraka Restaurant',
      'total': 'Total: \$',
      'delivering': 'Delivering',
      'completed': 'Completed',
      'processing': 'Processing',
      'canceled': 'Canceled',
      'phone': 'Phone',
      'orders_count': 'Orders Count',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
