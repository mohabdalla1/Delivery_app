import 'package:flutter/material.dart';

class MerchantsPage extends StatelessWidget {
  const MerchantsPage({super.key});

    @override
      Widget build(BuildContext context) {
          return Scaffold(
                appBar: AppBar(
                        title: const Text('إدارة المتاجر والتجار'),
                                centerTitle: true,
                                      ),
                                            body: ListView.builder(
                                                    itemCount: 5,
                                                            itemBuilder: (context, index) {
                                                                      return Card(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                                                              child: ListTile(
                                                                                                            leading: const CircleAvatar(
                                                                                                                            child: Icon(Icons.store),
                                                                                                                                          ),
                                                                                                                                                        title: Text('متجر التجربة ${index + 1}'),
                                                                                                                                                                      subtitle: const Text('التصنيف: مطاعم • الحالة: نشط'),
                                                                                                                                                                                    trailing: IconButton(
                                                                                                                                                                                                    icon: const Icon(Icons.more_vert),
                                                                                                                                                                                                                    onPressed: () {},
                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                              ),
                                                                                                                                                                                                                                                        );
                                                                                                                                                                                                                                                                },
                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                            floatingActionButton: FloatingActionButton(
                                                                                                                                                                                                                                                                                    onPressed: () {},
                                                                                                                                                                                                                                                                                            child: const Icon(Icons.add),
                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                        