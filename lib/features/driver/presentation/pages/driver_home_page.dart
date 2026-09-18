import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery_app/core/localization/app_localizations.dart';
import 'package:delivery_app/features/driver/data/models/driver_models.dart';
import 'package:delivery_app/features/driver/presentation/providers/driver_provider.dart';
import 'package:delivery_app/features/auth/presentation/pages/role_selection_page.dart';
import 'package:delivery_app/main.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});

  String _getActionButtonTitle(DriverJobStatus status, AppLocalizations tr) {
    switch (status) {
      case DriverJobStatus.accepted:
        return tr.translate('arrived_at_store');
      case DriverJobStatus.arrivedStore:
        return tr.translate('picked_up');
      case DriverJobStatus.pickedUp:
        return tr.translate('arrived_at_customer');
      case DriverJobStatus.arrivedCustomer:
        return tr.translate('complete_delivery');
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final driverProvider = Provider.of<DriverProvider>(context);
    final isArabic = appLocaleNotifier.value.languageCode == 'ar';
    final activeJob = driverProvider.activeJob;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(tr.translate('driver_dashboard')),
        centerTitle: true,
        backgroundColor: Colors.green,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Online/Offline Status Switch Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: driverProvider.isOnline ? Colors.green.shade100 : Colors.grey.shade300,
                      child: Icon(
                        Icons.directions_bike,
                        color: driverProvider.isOnline ? Colors.green : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          Text(
                            driverProvider.isOnline ? tr.translate('online_status') : tr.translate('offline_status'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: driverProvider.isOnline ? Colors.green : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: driverProvider.isOnline,
                      activeColor: Colors.green,
                      onChanged: (val) => driverProvider.toggleOnlineStatus(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Daily Stats
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
                        const Icon(Icons.account_balance_wallet, color: Colors.green, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          '${driverProvider.todayEarnings.toStringAsFixed(0)} ${tr.translate('currency')}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(tr.translate('today_earnings'), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
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
                        const Icon(Icons.check_circle, color: Colors.blue, size: 28),
                        const SizedBox(height: 8),
                        Text('${driverProvider.completedTrips}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(tr.translate('completed_trips'), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ACTIVE TRIP VIEW (If Driver has accepted a job)
            if (activeJob != null) ...[
              Text(
                tr.translate('active_trip'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAlignment.start,
                    children: [
                      // Simulated Interactive Map Container
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.map, color: Colors.white54, size: 48),
                                  const SizedBox(height: 8),
                                  Text(
                                    tr.translate('map_preview'),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${activeJob.storeName} ➔ ${activeJob.customerName}',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  '${activeJob.payout} ${tr.translate('currency')}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.store, color: Colors.orange),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAlignment.start,
                              children: [
                                Text('${tr.translate('pickup_from')}: ${activeJob.storeName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(activeJob.storeAddress, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.green),
                            onPressed: () {},
                          )
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.person_pin_circle, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAlignment.start,
                              children: [
                                Text('${tr.translate('deliver_to_customer')}: ${activeJob.customerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(activeJob.customerAddress, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.green),
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => driverProvider.advanceJobStatus(),
                          child: Text(
                            _getActionButtonTitle(activeJob.status, tr),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => driverProvider.cancelActiveJob(),
                          child: Text(tr.translate('cancel_trip'), style: const TextStyle(color: Colors.red)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ] else ...[
              // AVAILABLE NEARBY ORDERS LIST
              Text(
                tr.translate('available_orders'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (!driverProvider.isOnline)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(tr.translate('offline_status'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                )
              else if (driverProvider.availableJobs.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(tr.translate('no_available_orders'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: driverProvider.availableJobs.length,
                  itemBuilder: (context, index) {
                    final job = driverProvider.availableJobs[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.near_me, color: Colors.green, size: 20),
                                    const SizedBox(width: 6),
                                    Text('${job.distanceKm} كم', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text(
                                  '${job.payout} ${tr.translate('currency')}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                              ],
                            ),
                            const Divider(height: 20),
                            Text('${tr.translate('pickup_from')}: ${job.storeName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(job.storeAddress, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            const SizedBox(height: 8),
                            Text('${tr.translate('deliver_to_customer')}: ${job.customerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(job.customerAddress, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => driverProvider.acceptJob(job.id),
                                child: Text(tr.translate('accept_job'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
