import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:real_estate_1a/features/payment/data/paymentapi.dart';

part 'payment_state.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final Paymentapi paymentapi;

  PaymentCubit(this.paymentapi)
      : super(PaymentInitial());

  Future<void> makeorder(int propertyId) async {
    try {
      emit(PaymentLoading());

      final paymentUrl =
          await paymentapi.createOrder(propertyId);

      emit(PaymentSuccess(paymentUrl));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}