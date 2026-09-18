import 'package:flutter/material.dart';
import 'package:delivery_app/features/driver/data/models/driver_models.dart';

class DriverProvider extends ChangeNotifier {
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  double _todayEarnings = 2500.0;
  double get todayEarnings => _todayEarnings;

  int _completedTrips = 5;
  int get completedTrips => _completedTrips;

  DriverJobModel? _activeJob;
  DriverJobModel? get activeJob => _activeJob;

  final List<DriverJobModel> _availableJobs = [
    DriverJobModel(
      id: 'job_101',
      storeName: 'مطعم البركة والخير',
      storeAddress: 'الخرطوم - شارع الستين',
      storePhone: '0911111111',
      customerName: 'محمد أحمد',
      customerAddress: 'الخرطوم - حي الرياض حارة 4',
      customerPhone: '0922222222',
      payout: 500.0,
      distanceKm: 3.2,
      orderSummary: '2x وجبة برجر + 1x عصير طازج',
    ),
    DriverJobModel(
      id: 'job_102',
      storeName: 'سوبرماركت المدينة',
      storeAddress: 'أمبدة - الحارة 5',
      storePhone: '0933333333',
      customerName: 'فاطمة العوض',
      customerAddress: 'أمبدة - الحي الثالث',
      customerPhone: '0944444444',
      payout: 400.0,
      distanceKm: 1.8,
      orderSummary: 'مستلزمات منزلية خفيفة',
    ),
  ];

  List<DriverJobModel> get availableJobs => List.unmodifiable(_availableJobs);

  void toggleOnlineStatus() {
    _isOnline = !_isOnline;
    notifyListeners();
  }

  void acceptJob(String jobId) {
    final index = _availableJobs.indexWhere((j) => j.id == jobId);
    if (index >= 0) {
      _activeJob = _availableJobs[index];
      _activeJob!.status = DriverJobStatus.accepted;
      _availableJobs.removeAt(index);
      notifyListeners();
    }
  }

  void advanceJobStatus() {
    if (_activeJob == null) return;

    switch (_activeJob!.status) {
      case DriverJobStatus.accepted:
        _activeJob!.status = DriverJobStatus.arrivedStore;
        break;
      case DriverJobStatus.arrivedStore:
        _activeJob!.status = DriverJobStatus.pickedUp;
        break;
      case DriverJobStatus.pickedUp:
        _activeJob!.status = DriverJobStatus.arrivedCustomer;
        break;
      case DriverJobStatus.arrivedCustomer:
        _activeJob!.status = DriverJobStatus.completed;
        _todayEarnings += _activeJob!.payout;
        _completedTrips += 1;
        _activeJob = null; // الرحلة اكتملت
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void cancelActiveJob() {
    if (_activeJob != null) {
      _activeJob!.status = DriverJobStatus.available;
      _availableJobs.add(_activeJob!);
      _activeJob = null;
      notifyListeners();
    }
  }
}
