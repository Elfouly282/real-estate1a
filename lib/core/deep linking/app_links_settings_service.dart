// import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart';
//
// class AppLinksSettingsService {
//   AppLinksSettingsService();
//   static final AppLinksSettingsService instance = AppLinksSettingsService();
//
//   static const MethodChannel channel = MethodChannel(
//     'app.superbaba/app_links_settings',
//   );
//
//   Future<bool> openAppLinksSettings() async {
//     try {
//       if (defaultTargetPlatform != TargetPlatform.android) {
//         debugPrint('AppLinksSettingsService: Only available on Android');
//         return false;
//       }
//
//       final result = await channel.invokeMethod<bool>('openAppLinksSettings');
//       return result ?? false;
//     } on PlatformException catch (e) {
//       debugPrint(
//         'AppLinksSettingsService: Failed to open App Links settings: ${e.message}',
//       );
//       return false;
//     } catch (e) {
//       debugPrint('AppLinksSettingsService: Error: $e');
//       return false;
//     }
//   }
// }
//
//
//
