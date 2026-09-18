import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:delivery_app/features/customer/presentation/providers/customer_home_provider.dart';
import 'package:delivery_app/features/customer/presentation/providers/cart_provider.dart';
import 'package:delivery_app/features/merchant/presentation/providers/merchant_provider.dart';
import 'package:delivery_app/features/driver/presentation/providers/driver_provider.dart';
import 'package:delivery_app/features/admin/presentation/pages/merchants_page.dart';
import 'package:delivery_app/features/admin/presentation/pages/drivers_page.dart';
import 'package:delivery_app/features/admin/presentation/pages/orders_page.dart';
import 'package:delivery_app/features/admin/presentation/pages/customers_page.dart';

final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(const Locale('ar'));

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerHomeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MerchantProvider()),
        ChangeNotifierProvider(create: (_) => DriverProvider()),
      ],
      child: const DeliveryApp(),
    ),
  );
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, child) {
        return MaterialApp(
          title: 'Delivery App',
          debugShowCheckedModeBanner: false,
          locale: currentLocale,
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          home: const RoleSelectionPage(),
        );
      },
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final isArabic = appLocaleNotifier.value.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.translate('dashboard_title')),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.language, color: Colors.deepOrange),
            label: Text(
              tr.translate('switch_lang'),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
            onPressed: () {
              appLocaleNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepOrange),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_shipping, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    tr.translate('system_name'),
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text(tr.translate('home')),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(tr.translate('merchants')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pedal_bike),
              title: Text(tr.translate('drivers')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DriversPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(tr.translate('orders')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: Text(tr.translate('customers')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomersPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _StatCard(title: tr.translate('total_orders'), value: '1,240', icon: Icons.shopping_bag, color: Colors.blue),
            _StatCard(title: tr.translate('active_merchants'), value: '85', icon: Icons.store, color: Colors.green),
            _StatCard(title: tr.translate('available_drivers'), value: '42', icon: Icons.directions_bike, color: Colors.orange),
            _StatCard(title: tr.translate('total_sales'), value: '\$15,400', icon: Icons.attach_money, color: Colors.purple),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
