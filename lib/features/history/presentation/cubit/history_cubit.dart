import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';
import '../../domain/usecases/history_usecases.dart';

part 'history_state.dart';

@injectable
class HistortyCubit extends Cubit<HistoryState> {
  final GetHistoryUseCase    getHistoryUseCase;


  HistortyCubit({
    required this.getHistoryUseCase,

  }) : super(HistoryInitial());

  // ── Get favorites ──────────────────────────────────────────────────────────

  Future<void> getHistory({int page = 1}) async {
    emit(HistoryLoading());

    final result = await getHistoryUseCase.invoke(page: page);
    result.fold(
          (failure) => emit(HistoryError(failure.message)),
          (data) {
        emit(HistorySuccess(data));
      },
    );
  }
  }

