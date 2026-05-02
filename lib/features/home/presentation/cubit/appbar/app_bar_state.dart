part of 'app_bar_cubit.dart';

enum LocationStatus { initial, loading, loaded, error }

class AppBarState {
  final String location;
  final LocationStatus locationStatus;
  final bool hasNotification;
  final bool hasMessage;

  const AppBarState({
    this.location = '',
    this.locationStatus = LocationStatus.initial,
    this.hasNotification = true,
    this.hasMessage = true,
  });

  AppBarState copyWith({
    String? location,
    LocationStatus? locationStatus,
    bool? hasNotification,
    bool? hasMessage,
  }) =>
      AppBarState(
        location:        location        ?? this.location,
        locationStatus:  locationStatus  ?? this.locationStatus,
        hasNotification: hasNotification ?? this.hasNotification,
        hasMessage:      hasMessage      ?? this.hasMessage,
      );
}
