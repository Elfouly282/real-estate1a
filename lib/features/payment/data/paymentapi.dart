import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/api/dio_helper.dart';

@lazySingleton
class Paymentapi {
  Future<String> createOrder(int propertyId) async {
    try {
      final response = await DioHelper.postData(
        url: 'orders',
        data: {
          "property_id": propertyId,
        },
        withAuth: true,
      );

      final paymentUrl =
          response.data["data"]["payment_url"];

      return paymentUrl;
    } catch (e, stack) {
      print('🧨 $stack');
      if (e is DioException)
      {
        String? msg;

         msg =e.response?.data["message"];
       throw (msg ??"Unable to complete your payment right now. " ) ;
      }
      throw ("Unable to complete your payment right now");
    }
  }
}