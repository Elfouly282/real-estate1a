import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_1a/gen/assets.gen.dart';

class PropertyLocationMap extends StatefulWidget {
  static const String routename = "/mapdetails";
  final double latitude;
  final double longitude;

  const PropertyLocationMap({required this.latitude, required this.longitude});

  @override
  State<PropertyLocationMap> createState() => _PropertyLocationMapState();
}

class _PropertyLocationMapState extends State<PropertyLocationMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
 // static BitmapDescriptor? cachedMarker;
  BitmapDescriptor? customIcon;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarker();
  }

  Future<void> _loadMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      Assets.images.realestate.path,
    );

    markers = {
      Marker(
        markerId: const MarkerId("property_location"),
        position: LatLng(widget.latitude, widget.longitude),
        icon: customIcon!,
      ),
    };

    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 180,
        width: double.infinity,
    
        child: Stack(
          children: [
            GoogleMap(
              markers: markers,
    
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 13,
              ),
    
              onMapCreated: (controller) {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
              },
    
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
     /// Zoom in , out
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                children: [
                  _buildMapButton(Icons.add, onTap: _zoomIn),
    
                  const SizedBox(height: 10),
    
                  _buildMapButton(Icons.remove, onTap: _zoomOut),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _zoomIn() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }
}

Widget _buildMapButton(IconData icon, {required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(icon),
    ),
  );
}
