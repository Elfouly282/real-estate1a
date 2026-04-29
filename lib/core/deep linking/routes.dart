// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../features/products/presentation/view/screen/product_detail_screen.dart';
//
// class AppRoutes {
//   static const String productDetailScreen = '/product';
// }
//
// class AppRouteGenerator {
//   static const PageTransitionType defaultTransition = PageTransitionType.fade;
//
//   static Route<dynamic> generateRoute(
//     RouteSettings settings, {
//     PageTransitionType? transitionType,
//   }) {
//     Widget page;
//     final transition = transitionType ?? defaultTransition;
//
//     final incomingName = settings.name ?? '';
//
//     if (incomingName.startsWith('bayoumi://') ||
//         incomingName.startsWith('https://bayoumistore.com') ||
//         incomingName.startsWith('http://bayoumistore.com')) {
//       final uri = Uri.tryParse(incomingName);
//       if (uri != null && uri.pathSegments.isNotEmpty) {
//         if (uri.pathSegments.first == 'product' &&
//             uri.pathSegments.length >= 2) {
//           String slug = uri.pathSegments[1];
//           try {
//             slug = Uri.decodeComponent(slug);
//           } catch (e) {}
//           page = ProductDetailScreen.fromSlug(slug: slug);
//           return PageTransition(
//             child: page,
//             type: transition,
//             settings: settings,
//             duration: const Duration(milliseconds: 300),
//             reverseDuration: const Duration(milliseconds: 300),
//           );
//         }
//       }
//     }
//
//     if (incomingName.startsWith('/')) {
//       final trimmed = incomingName.replaceFirst(RegExp(r'^/+'), '');
//       final parts = trimmed.split('/');
//       if (parts.isNotEmpty) {
//         if (parts.first == 'product' && parts.length >= 2) {
//           String slug = parts[1];
//           try {
//             slug = Uri.decodeComponent(slug);
//           } catch (e) {}
//           page = ProductDetailScreen.fromSlug(slug: slug);
//           return PageTransition(
//             child: page,
//             type: transition,
//             settings: settings,
//             duration: const Duration(milliseconds: 300),
//             reverseDuration: const Duration(milliseconds: 300),
//           );
//         }
//       }
//     }
//
//     return MaterialPageRoute(
//       builder:
//           (_) => const Scaffold(body: Center(child: Text('Route not found'))),
//     );
//   }
// }
