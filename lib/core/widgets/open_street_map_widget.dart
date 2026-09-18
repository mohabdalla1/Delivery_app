import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String markerTitle;

  const OpenStreetMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.markerTitle = 'الموقع',
  });

  @override
  Widget build(BuildContext context) {
    // إحداثيات الخرطوم (افتراضية أو مستلمة)
    final LatLng position = LatLng(latitude, longitude);

    return FlutterMap(
      options: MapOptions(
        initialCenter: position,
        initialZoom: 15.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.tekno.delivery_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: position,
              width: 80,
              height: 80,
              child: const Column(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.deepOrange,
                    size: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
