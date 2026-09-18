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
      'select_role': 'اختر نوع الحساب',
      'choose_role_subtitle': 'قم باختيار نوع الحساب للمتابعة في التطبيق',
      'role_customer': 'عميل',
      'role_customer_desc': 'تصفح المتاجر واطلب الوجبات والمنتجات بسهولة',
      'role_merchant': 'متجر / تاجر',
      'role_merchant_desc': 'إدارة منتجاتك، استقبال الطلبات ومتابعة المبيعات',
      'role_driver': 'سائق توصيل',
      'role_driver_desc': 'استلام طلبات التوصيل، تتبع الخريطة وتحصيل الأرباح',
      'role_admin': 'مسؤول النظام (Admin)',
      'role_admin_desc': 'إدارة المنصة بالكامل، التجار، السائقين والإحصائيات',
      'login_title': 'تسجيل الدخول',
      'welcome_back': 'مرحباً بك مجدداً',
      'login_subtitle': 'الرجاء إدخال بيانات الحساب للمتابعة',
      'email_or_phone': 'البريد الإلكتروني أو رقم الهاتف',
      'password': 'كلمة المرور',
      'forgot_password': 'هل نسيت كلمة المرور؟',
      'sign_in': 'تسجيل الدخول',
      'dont_have_account': 'ليس لديك حساب؟',
      'create_account': 'إنشاء حساب جديد',
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
      'select_role': 'Select Account Type',
      'choose_role_subtitle': 'Choose your account type to proceed',
      'role_customer': 'Customer',
      'role_customer_desc': 'Browse stores, order food and products easily',
      'role_merchant': 'Merchant / Store',
      'role_merchant_desc': 'Manage products, receive orders, track sales',
      'role_driver': 'Delivery Driver',
      'role_driver_desc': 'Accept delivery jobs, track routes, earn income',
      'role_admin': 'System Admin',
      'role_admin_desc': 'Full platform management, merchants, drivers & analytics',
      'login_title': 'Sign In',
      'welcome_back': 'Welcome Back',
      'login_subtitle': 'Please enter your credentials to continue',
      'email_or_phone': 'Email or Phone Number',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'sign_in': 'Sign In',
      'dont_have_account': "Don't have an account?",
      'create_account': 'Create New Account',
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
