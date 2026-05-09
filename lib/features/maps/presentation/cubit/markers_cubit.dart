import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:real_estate_1a/features/maps/domain/entities/marker_entity.dart';
import 'package:real_estate_1a/features/maps/domain/usecase/get_marker.dart';
part 'markers_state.dart';

@injectable
class MarkersCubit extends Cubit<MarkersState> {
  GetMarkerUsecase getMarkerUsecase;
  MarkersCubit(this.getMarkerUsecase) : super(MarkersInitial());

  void fetchMarkers() async {
    emit(MarkersLoading());
    final result = await getMarkerUsecase.call();
    result.fold(
      (e) => emit(MarkersError(e.toString())),
      (markers) => emit(MarkersLoaded(markers)),
    );
  }
}
