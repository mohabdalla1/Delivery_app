import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الطلبات'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          final statuses = ['قيد التوصيل', 'مكتمل', 'قيد المعالجة', 'ملغى'];
          final colors = [Colors.orange, Colors.green, Colors.blue, Colors.red];
          final statusIndex = index % statuses.length;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.receipt_long),
              ),
              title: Text('طلب رقم #${1024 + index}'),
              subtitle: Text('المتجر: مطعم البركة • الإجمالي: \$${(index + 1) * 15}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors[statusIndex].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statuses[statusIndex],
                  style: TextStyle(color: colors[statusIndex], fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
