import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/features/merchant/data/models/merchant_models.dart';
import 'package:delivery_app/features/merchant/presentation/providers/merchant_provider.dart';
import 'package:delivery_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:delivery_app/main.dart';

class MerchantHomePage extends StatefulWidget {
  const MerchantHomePage({super.key});

  @override
  State<MerchantHomePage> createState() => _MerchantHomePageState();
}

class _MerchantHomePageState extends State<MerchantHomePage> {
  int _selectedTabIndex = 0;

  void _showAddEditProductDialog(BuildContext context, {MerchantProductModel? product}) {
    final tr = AppLocalizations.of(context);
    final provider = Provider.of<MerchantProvider>(context, listen: false);

    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product?.price.toString() ?? '');
    final categoryController = TextEditingController(text: product?.category ?? 'مطاعم');
    final descController = TextEditingController(text: product?.description ?? '');
    bool isAvailable = product?.isAvailable ?? true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(product == null ? tr.translate('add_new_product') : tr.translate('edit_product')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: tr.translate('product_name_label'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: tr.translate('product_price_label'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: tr.translate('category'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: tr.translate('description'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: Text(tr.translate('available_status')),
                  value: isAvailable,
                  activeColor: Colors.orange,
                  onChanged: (val) {
                    setDialogState(() => isAvailable = val);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(tr.translate('cancel')),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (nameController.text.isEmpty || priceController.text.isEmpty) return;
                final price = double.tryParse(priceController.text) ?? 0.0;

                if (product == null) {
                  provider.addProduct(
                    MerchantProductModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      price: price,
                      category: categoryController.text,
                      description: descController.text,
                      isAvailable: isAvailable,
                    ),
                  );
                } else {
                  product.name = nameController.text;
                  product.price = price;
                  product.category = categoryController.text;
                  product.description = descController.text;
                  product.isAvailable = isAvailable;
                  provider.updateProduct(product);
                }
                Navigator.pop(ctx);
              },
              child: Text(tr.translate('save')),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(MerchantOrderStatus status) {
    switch (status) {
      case MerchantOrderStatus.newOrder:
        return Colors.blue;
      case MerchantOrderStatus.preparing:
        return Colors.orange;
      case MerchantOrderStatus.ready:
        return Colors.green;
      case MerchantOrderStatus.completed:
        return Colors.grey;
      case MerchantOrderStatus.canceled:
        return Colors.red;
    }
  }

  String _getStatusText(MerchantOrderStatus status, AppLocalizations tr) {
    switch (status) {
      case MerchantOrderStatus.newOrder:
        return tr.translate('order_status_new');
      case MerchantOrderStatus.preparing:
        return tr.translate('order_status_preparing');
      case MerchantOrderStatus.ready:
        return tr.translate('order_status_ready');
      case MerchantOrderStatus.completed:
        return tr.translate('order_status_completed');
      case MerchantOrderStatus.canceled:
        return tr.translate('order_status_canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final merchantProvider = Provider.of<MerchantProvider>(context);
    final isArabic = appLocaleNotifier.value.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(tr.translate('merchant_dashboard')),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              appLocaleNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTabIndex,
        children: [
          // 1. Dashboard & Orders Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Store Open / Close Status Card
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: merchantProvider.isStoreOpen ? Colors.green.shade100 : Colors.red.shade100,
                          child: Icon(
                            merchantProvider.isStoreOpen ? Icons.store : Icons.store_outlined,
                            color: merchantProvider.isStoreOpen ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr.translate('store_status'),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                merchantProvider.isStoreOpen ? tr.translate('store_open') : tr.translate('store_closed'),
                                style: TextStyle(
                                  color: merchantProvider.isStoreOpen ? Colors.green : Colors.red,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: merchantProvider.isStoreOpen,
                          activeColor: Colors.orange,
                          onChanged: (val) => merchantProvider.toggleStoreStatus(),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Stats Grid
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.shopping_bag, color: Colors.orange, size: 28),
                            const SizedBox(height: 8),
                            Text('${merchantProvider.todayOrdersCount}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(tr.translate('today_orders_count'), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.green, size: 28),
                            const SizedBox(height: 8),
                            Text('${merchantProvider.todaySales.toStringAsFixed(0)} ${tr.translate('currency')}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(tr.translate('today_sales'), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  tr.translate('incoming_orders'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: merchantProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = merchantProvider.orders[index];
                    final statusColor = _getStatusColor(order.status);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('طلب #${order.orderId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getStatusText(order.status, tr),
                                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            const Divider(height: 20),
                            Text('العميل: ${order.customerName} (${order.customerPhone})', style: const TextStyle(fontSize: 13)),
                            const SizedBox(height: 4),
                            Text('العنوان: ${order.deliveryAddress}', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                            if (order.customerNote != null && order.customerNote!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text('ملاحظات: ${order.customerNote}', style: const TextStyle(fontSize: 12, color: Colors.deepOrange, fontStyle: FontStyle.italic)),
                            ],
                            const SizedBox(height: 12),
                            Column(
                              children: order.items
                                  .map((item) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${item.quantity}x ${item.productName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text('${item.totalPrice} ${tr.translate('currency')}'),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${tr.translate('total_amount')}: ${order.totalAmount} ${tr.translate('currency')}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                if (order.status == MerchantOrderStatus.newOrder) ...[
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                                        onPressed: () => merchantProvider.updateOrderStatus(order.orderId, MerchantOrderStatus.canceled),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                                        onPressed: () => merchantProvider.updateOrderStatus(order.orderId, MerchantOrderStatus.preparing),
                                        child: Text(tr.translate('accept')),
                                      ),
                                    ],
                                  )
                                ] else if (order.status == MerchantOrderStatus.preparing) ...[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                    onPressed: () => merchantProvider.updateOrderStatus(order.orderId, MerchantOrderStatus.ready),
                                    child: Text(tr.translate('ready_for_pickup')),
                                  ),
                                ]
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),

          // 2. Products Management Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: merchantProvider.products.length,
              itemBuilder: (context, index) {
                final product = merchantProvider.products[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: product.isAvailable ? Colors.orange.shade100 : Colors.grey.shade300,
                      child: Icon(Icons.fastfood, color: product.isAvailable ? Colors.orange : Colors.grey),
                    ),
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('${product.price} ${tr.translate('currency')} • ${product.category}'),
                        Text(
                          product.isAvailable ? tr.translate('available_status') : tr.translate('out_of_stock_status'),
                          style: TextStyle(color: product.isAvailable ? Colors.green : Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: product.isAvailable,
                          activeColor: Colors.orange,
                          onChanged: (_) => merchantProvider.toggleProductAvailability(product.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddEditProductDialog(context, product: product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => merchantProvider.deleteProduct(product.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedTabIndex == 1
          ? FloatingActionButton.extended(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              onPressed: () => _showAddEditProductDialog(context),
              icon: const Icon(Icons.add),
              label: Text(tr.translate('add_new_product')),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedTabIndex = index),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.store), label: tr.translate('home')),
          BottomNavigationBarItem(icon: const Icon(Icons.inventory_2), label: tr.translate('products_management')),
        ],
      ),
    );
  }
}
