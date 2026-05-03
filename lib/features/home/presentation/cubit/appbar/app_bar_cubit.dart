import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/service/location_service.dart';

part 'app_bar_state.dart'; // ← المهم السطر ده موجود
@injectable
class AppBarCubit extends Cubit<AppBarState> {
  final LocationService locationService;
  AppBarCubit({required this.locationService}) : super(const AppBarState());
  Future<void> fetchLocation() async {
    emit(state.copyWith(locationStatus: LocationStatus.loading));

    final result = await locationService.getCurrentLocationName();
    result.fold(
          (failure) => emit(state.copyWith(
        location: failure.message,
        locationStatus: LocationStatus.error,
      )),
          (locationName) => emit(state.copyWith(
        location: locationName.name,
        locationStatus: LocationStatus.loaded,
      )),
    );
  }
  void clearNotification() => emit(state.copyWith(hasNotification: false));
  void clearMessage() => emit(state.copyWith(hasMessage: false));

}