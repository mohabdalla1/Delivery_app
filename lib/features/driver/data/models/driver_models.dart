enum DriverJobStatus { available, accepted, arrivedStore, pickedUp, arrivedCustomer, completed }

class DriverJobModel {
  final String id;
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final double payout;
  final double distanceKm;
  final String orderSummary;
  DriverJobStatus status;

  DriverJobModel({
    required this.id,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.payout,
    required this.distanceKm,
    required this.orderSummary,
    this.status = DriverJobStatus.available,
  });
}
