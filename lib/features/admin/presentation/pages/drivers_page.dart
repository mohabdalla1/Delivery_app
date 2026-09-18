import 'package:flutter/material.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة السائقين'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.directions_bike),
              ),
              title: Text('السائق ${index + 1}'),
              subtitle: const Text('المركبة: دراجة نارية • الحالة: نشط'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('متاح', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
