import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../theme/app_theme.dart';

class MockMap extends StatelessWidget {
  const MockMap({super.key, this.center, this.zoom = 14, this.markers = const []});

  final LatLng? center;
  final double zoom;
  final List<Marker> markers;

  static final defaultCenter = LatLng(55.751244, 37.618423);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: center ?? defaultCenter,
        initialZoom: zoom,
        minZoom: 3,
        maxZoom: 19,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://core-renderer-tiles.maps.yandex.net/tiles?l=map&x={x}&y={y}&z={z}&scale=1&lang=ru_RU',
          userAgentPackageName: 'com.example.chayxana_app',
          maxNativeZoom: 19,
        ),
        if (markers.isNotEmpty) MarkerLayer(markers: markers),
      ],
    );
  }
}

class MapPin extends StatelessWidget {
  const MapPin({super.key, this.color = AppColors.accent, this.icon, this.size = 44, this.active = true});
  final Color color;
  final IconData? icon;
  final double size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final c = active ? color : AppColors.textSecondary.withValues(alpha: 0.6);
    return SizedBox(
      width: size,
      height: size * 1.2,
      child: CustomPaint(
        painter: _PinPainter(color: c),
        child: Padding(
          padding: EdgeInsets.only(bottom: size * 0.25),
          child: Center(
            child: Icon(icon ?? Icons.location_on, color: Colors.white, size: size * 0.5),
          ),
        ),
      ),
    );
  }
}

class _PinPainter extends CustomPainter {
  _PinPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;
    final r = w / 2;

    canvas.drawCircle(Offset(w / 2, r), r, paint);

    final tail = ui.Path()
      ..moveTo(w * 0.30, r * 1.6)
      ..lineTo(w / 2, h)
      ..lineTo(w * 0.70, r * 1.6)
      ..close();
    canvas.drawPath(tail, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
