import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GardenMapBox extends StatefulWidget {
  const GardenMapBox({
    super.key,
    required this.initialPosition,
    required this.gardenName,
  });

  final LatLng initialPosition;
  final String gardenName;

  @override
  State<GardenMapBox> createState() => _GardenMapBoxState();
}

class _GardenMapBoxState extends State<GardenMapBox> {
  static const double _defaultZoom = 15;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: _defaultZoom,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('garden'),
          position: widget.initialPosition,
          infoWindow: InfoWindow(title: widget.gardenName),
        ),
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      liteModeEnabled: false,
    );
  }
}
