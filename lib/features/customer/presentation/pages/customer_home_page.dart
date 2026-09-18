import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/features/customer/presentation/providers/customer_home_provider.dart';
import 'package:delivery_app/main.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final homeProvider = Provider.of<CustomerHomeProvider>(context);
    final isArabic = appLocaleNotifier.value.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAlignment.start,
                          children: [
                            Text(
                              tr.translate('deliver_to'),
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_on, color: Colors.deepOrange, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  'الخرطوم، أمبدة',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Icon(Icons.keyboard_arrow_down, size: 18),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.language, color: Colors.deepOrange),
                              onPressed: () {
                                appLocaleNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_outlined),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: tr.translate('search_hint'),
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                          prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.tune, color: Colors.deepOrange, size: 20),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 140,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(tr.translate('today_offers'), style: const TextStyle(color: Colors.white, fontSize: 11)),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tr.translate('banner_discount'),
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Icon(
                        Icons.local_offer,
                        size: 90,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: homeProvider.categories.length,
                    itemBuilder: (context, index) {
                      final cat = homeProvider.categories[index];
                      final isSelected = homeProvider.selectedCategoryIndex == index;

                      return GestureDetector(
                        onTap: () => homeProvider.selectCategory(index),
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.deepOrange : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                child: Icon(
                                  cat.icon,
                                  color: isSelected ? Colors.white : Colors.grey[700],
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tr.translate(cat.nameKey),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? Colors.deepOrange : Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr.translate('featured_stores'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {},
                      child: Text(tr.translate('see_all'), style: const TextStyle(color: Colors.deepOrange, fontSize: 13)),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: homeProvider.featuredStores.length,
                  itemBuilder: (context, index) {
                    final store = homeProvider.featuredStores[index];
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                            ),
                            child: const Center(child: Icon(Icons.store, size: 40, color: Colors.deepOrange)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAlignment.start,
                              children: [
                                Text(
                                  store.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    Text(' ${store.rating} ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text('${tr.translate('delivery_fee')} ${store.deliveryFee} ${tr.translate('currency')}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr.translate('popular_products'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {},
                      child: Text(tr.translate('see_all'), style: const TextStyle(color: Colors.deepOrange, fontSize: 13)),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = homeProvider.popularProducts[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                              ),
                              child: const Center(child: Icon(Icons.fastfood, size: 40, color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  product.storeName,
                                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${product.price} ${tr.translate('currency')}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 13),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(Icons.add, color: Colors.white, size: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  childCount: homeProvider.popularProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_filled), label: tr.translate('nav_home')),
          BottomNavigationBarItem(icon: const Icon(Icons.explore), label: tr.translate('nav_explore')),
          BottomNavigationBarItem(icon: const Icon(Icons.receipt_long), label: tr.translate('nav_orders')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: tr.translate('nav_profile')),
        ],
      ),
    );
  }
}
