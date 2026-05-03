part of 'app_bar_cubit.dart';

enum LocationStatus { initial, loading, loaded, error }

class AppBarState {
  final String location;
  final double? latitude;
  final double? longitude;
  final LocationStatus locationStatus;
  final bool hasNotification;
  final bool hasMessage;

  const AppBarState({
    this.location = '',
    this.latitude,
    this.longitude,
    this.locationStatus = LocationStatus.initial,
    this.hasNotification = true,
    this.hasMessage = true,
  });

  AppBarState copyWith({
    String? location,
    double? latitude,
    double? longitude,
    LocationStatus? locationStatus,
    bool? hasNotification,
    bool? hasMessage,
  }) =>
      AppBarState(
        location:        location        ?? this.location,
        latitude:        latitude        ?? this.latitude,
        longitude:       longitude       ?? this.longitude,
        locationStatus:  locationStatus  ?? this.locationStatus,
        hasNotification: hasNotification ?? this.hasNotification,
        hasMessage:      hasMessage      ?? this.hasMessage,
      );
}