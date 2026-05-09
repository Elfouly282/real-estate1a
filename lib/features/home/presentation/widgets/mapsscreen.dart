// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:real_estate_1a/features/home/presentation/widgets/appbar_map.dart';
// import 'package:real_estate_1b/features/home/presentation/cubit/markers_cubit.dart';
// import 'package:real_estate_1b/features/home/presentation/widgets/appbar_map.dart';

// class MapTest extends StatefulWidget {
//   static const String routeName = "/map";

//   const MapTest({super.key});

//   @override
//   State<MapTest> createState() => _MapTestState();
// }
// class _MapTestState extends State<MapTest> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   Set<Marker> markers = {};
 
//   BitmapDescriptor? customIcon;

//   @override
//   void initState() {
//     super.initState();
//     context.read<MarkersCubit>().fetchMarkers();
//     _loadCustomIcon();
//   }

//   Future<void> _loadCustomIcon() async {
//     customIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(48, 48)),
//       'assets/icons/re2.png',
//     );
//   }

//   void _updateMarkers(List markersData) {
//     if (customIcon == null) return;

//     markers = markersData.map((marker) {
//       return Marker(
//         markerId: MarkerId(marker.id.toString()),
//         position: LatLng(marker.latitude, marker.longitude),
//         icon: customIcon!,
//       );
//     }).toSet();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final heightscreen = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       appBar: buildAppBar(),

//       body: BlocBuilder<MarkersCubit, MarkersState>(
//         builder: (context, state) {
//           if (state is MarkersLoading) {
//             return const Center(child: CircularProgressIndicator(
//               color: Color(0XFF1597A8),
//             ));
//           }

//           if (state is MarkersError) {
//             return Center(child: Text(state.message));
//           }

//           if (state is MarkersLoaded) {
//             _updateMarkers(state.markers);

//             return Stack(
//               children: [
//                 /// MAP widget
//                 GoogleMap(
//                   markers: markers,
//                   onMapCreated: (controller) {
//                     _controller.complete(controller);
//                   },
//                   initialCameraPosition: const CameraPosition(
//                     target: LatLng(30.0444, 31.2357),
//                     zoom: 10,
//                   ),
//                   myLocationEnabled: true,
//                   zoomControlsEnabled: false,
//                 ),

//                 /// ZOOM BUTTONS
//                 Positioned(
//                   right: 16,
//                   bottom: 70,
//                   child: Column(
//                     children: [
//                       _buildMapButton(Icons.add, onTap: _zoomIn),
//                       SizedBox(height: heightscreen * .02),
//                       _buildMapButton(Icons.remove, onTap: _zoomOut),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Future<void> _zoomIn() async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.zoomIn());
//   }

//   Future<void> _zoomOut() async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.zoomOut());
//   }
// }

// // *-------------------------- Button map
// Widget _buildMapButton(IconData icon, {required VoidCallback onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       width: 52,
//       height: 52,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.08),
//             blurRadius: 14,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Icon(icon),
//     ),
//   );
// }
