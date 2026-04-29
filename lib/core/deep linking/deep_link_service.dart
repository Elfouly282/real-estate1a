// import 'dart:async';
//
// import 'package:app_links/app_links.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'navigation.dart';
// import '../../features/suppliser/presentation/screen/suppliers_profile_screen.dart';
//
// class DeepLinkService {
//   DeepLinkService();
//   static final DeepLinkService instance = DeepLinkService();
//
//   StreamSubscription<Uri>? sub;
//   AppLinks? appLinks;
//
//   static const String baseHost = 'superbaba.app';
//
//   Future<void> initialize() async {
//     if (!(defaultTargetPlatform == TargetPlatform.android ||
//         defaultTargetPlatform == TargetPlatform.iOS)) {
//       return;
//     }
//
//     appLinks ??= AppLinks();
//
//     try {
//       final initialUri = await appLinks!.getInitialLink();
//       if (initialUri != null) {
//         handleUri(initialUri);
//       }
//     } on PlatformException catch (e, st) {
//       debugPrint('DeepLinkService getInitialLink: $e\n$st');
//     }
//
//     sub?.cancel();
//     sub = appLinks!.uriLinkStream.listen(
//       handleUri,
//       onError: (Object _) {},
//     );
//   }
//
//   void dispose() {
//     sub?.cancel();
//     sub = null;
//   }
//
//   void handleUri(Uri uri) {
//     debugPrint('DeepLinkService: Handling URI: $uri');
//
//     if (uri.host != baseHost) return;
//
//     final path = uri.path;
//
//     if (path == '/profile') {
//       final supplierIdStr = uri.queryParameters['supplier_id'];
//       final supplierId = int.tryParse(supplierIdStr ?? '');
//
//       if (supplierId != null) {
//         debugPrint('DeepLinkService: Navigating to supplier profile: $supplierId');
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           appNavigatorKey.currentState?.push(
//             MaterialPageRoute(
//               builder: (_) => SuppliersProfileScreen(supplierId: supplierId),
//             ),
//           );
//         });
//       }
//     }
//   }
// }
