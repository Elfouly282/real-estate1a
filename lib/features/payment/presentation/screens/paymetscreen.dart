// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:real_estate_1a/core/di/di.dart';
// import 'package:real_estate_1a/core/utils/app_colors.dart';
// import 'package:real_estate_1a/features/payment/presentation/cubit/payment_cubit.dart';
// import 'package:real_estate_1a/features/property_details/domain/entities/property_details_entity.dart';

// class Paymetscreen extends StatefulWidget {
//   const Paymetscreen({super.key});

//   static const String routeName = "/payment";

//   @override
//   State<Paymetscreen> createState() => _PaymetscreenState();
// }

// class _PaymetscreenState extends State<Paymetscreen> {
//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final int servicefee = 250;
//     final formattedDate =
//         "${now.day}/${now.month}/${now.year} - ${now.hour}:${now.minute}";
//     final data =
//         ModalRoute.of(context)!.settings.arguments as PropertyDetailsEntity;

//     return BlocProvider(
//      create: (_) => getIt<PaymentCubit>(),
//       child: Scaffold(
//         backgroundColor: const Color(0xffF7F9FB),
//         appBar: AppBar(
//           backgroundColor: const Color(0xffF7F9FB),
//           elevation: 0,
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: const Text(
//             "Request to Book",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// PROPERTY CARD
//               Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.04),
//                       blurRadius: 10,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     /// SMALL IMAGE
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         '${data.images.first.url}',
//                         width: 60.w,
//                         height: 60.h,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
      
//                     SizedBox(width: 12.w),
      
//                     /// TEXT
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${data.category.description}",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
      
//                           SizedBox(height: 5.h),
      
//                           Text(
//                             '${data.address}',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 13,
//                             ),
//                           ),
      
//                           const SizedBox(height: 8),
      
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: 16,
//                               ),
      
//                               const SizedBox(width: 4),
      
//                               Text(
//                                 '${data.rate ?? ""}',
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
      
//                               const Spacer(),
      
//                               Text(
//                                 "\$${data.price}",
//                                 style: const TextStyle(
//                                   color: AppColors.infoColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
      
//               SizedBox(height: 28.h),
      
//               /// BOOKING DETAILS
//               Text(
//                 "Booking Detail",
//                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//               ),
      
//               const SizedBox(height: 18),
//               _buildBookingRow(title: "Book Appointment", value: formattedDate),
      
//               const Divider(height: 32),
      
//               _buildBookingRow(title: "Person", value: "4 person"),
      
//               SizedBox(height: 29.h),
      
//               /// PRICE DETAILS
//               Text(
//                 "Price details",
//                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//               ),
      
//               SizedBox(height: 18.h),
      
//               _buildPriceRow("House Prices", "\$${data.price}"),
      
//               SizedBox(height: 12.h),
      
//               _buildPriceRow("Service fee", "\$250"),
      
//               Divider(height: 32.h),
      
//               _buildPriceRow("Total", "\$${data.price + 250}", isTotal: true),
      
//               SizedBox(height: 32.h),
      
//               /// POLICY
//               Text(
//                 "Cancellation Policy",
//                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//               ),
      
//               SizedBox(height: 12.h),
      
//               Text(
//                 "Free cancellation within 48 hours. If canceled before June 1, you will receive a partial refund.",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   height: 1.5,
//                   fontSize: 14.sp,
//                 ),
//               ),
      
//               SizedBox(height: 40.h),
      
//               /// BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 58,
//                 child: ElevatedButton(
//                   onPressed: () {
//                      context.read<PaymentCubit>().makeorder(
//       data.id,
//         );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     backgroundColor: AppColors.infoColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: Text(
//                     "Continue Payment",
//                     style: TextStyle(
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBookingRow({required String title, required String value}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),

//         const SizedBox(height: 6),

//         Text(
//           value,
//           style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//         ),
//       ],
//     );
//   }

//   Widget _buildPriceRow(String title, String amount, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: isTotal ? 22.h : 18.h,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
//           ),
//         ),
//         Text(
//           amount,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 15,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
//             color: isTotal ? AppColors.infoColor : Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_1a/core/di/di.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:real_estate_1a/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:real_estate_1a/features/payment/presentation/screens/webviewpay.dart';
import 'package:real_estate_1a/features/property_details/domain/entities/property_details_entity.dart';

class Paymetscreen extends StatefulWidget {
  const Paymetscreen({super.key});

  static const String routeName = "/payment";

  @override
  State<Paymetscreen> createState() => _PaymetscreenState();
}

class _PaymetscreenState extends State<Paymetscreen> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final formattedDate =
        "${now.day}/${now.month}/${now.year} - ${now.hour}:${now.minute}";

    final data =
        ModalRoute.of(context)!.settings.arguments
            as PropertyDetailsEntity;

    return BlocProvider(
      create: (_) => getIt<PaymentCubit>(),

      child: BlocConsumer<PaymentCubit, PaymentState>(

        listener: (context, state) {

          if (state is PaymentSuccess) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentWebViewScreen(
                  paymentUrl: state.paymentUrl,
                ),
              ),
            );
          }

          if (state is PaymentError) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        builder: (context, state) {

          return Scaffold(
            backgroundColor: const Color(0xffF7F9FB),

            appBar: AppBar(
              backgroundColor: const Color(0xffF7F9FB),
              elevation: 0,
              centerTitle: true,

              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),

              title: const Text(
                "Request to Book",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  /// PROPERTY CARD
                  Container(
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: Image.network(
                            '${data.images.first.url}',
                            width: 60.w,
                            height: 60.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        /// TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                "${data.category.description}",

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5.h),

                              Text(
                                '${data.address}',

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [

                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    '${data.rate ?? ""}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const Spacer(),

                                  Text(
                                    "\$${data.price}",

                                    style: const TextStyle(
                                      color: AppColors.infoColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  /// BOOKING DETAILS
                  Text(
                    "Booking Detail",

                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  _buildBookingRow(
                    title: "Book Appointment",
                    value: formattedDate,
                  ),

                  const Divider(height: 32),

                  _buildBookingRow(
                    title: "Person",
                    value: "4 person",
                  ),

                  SizedBox(height: 29.h),

                  /// PRICE DETAILS
                  Text(
                    "Price details",

                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 18.h),

                  _buildPriceRow(
                    "House Prices",
                    "\$${data.price}",
                  ),

                  SizedBox(height: 12.h),

                  _buildPriceRow(
                    "Service fee",
                    "\$250",
                  ),

                  Divider(height: 32.h),

                  _buildPriceRow(
                    "Total",
                    "\$${data.price + 250}",
                    isTotal: true,
                  ),

                  SizedBox(height: 32.h),

                  /// POLICY
                  Text(
                    "Cancellation Policy",

                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Free cancellation within 48 hours. If canceled before June 1, you will receive a partial refund.",

                    style: TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: ElevatedButton(

                      onPressed: state is PaymentLoading
                          ? null
                          : () {

                              context
                                  .read<PaymentCubit>()
                                  .makeorder(data.id);
                            },

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            AppColors.infoColor,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),

                      child: state is PaymentLoading

                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )

                          : Text(
                              "Continue Payment",

                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingRow({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,

          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String title,
    String amount, {
    bool isTotal = false,
  }) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,

          style: TextStyle(
            fontSize: isTotal ? 22.h : 18.h,
            fontWeight:
                isTotal
                    ? FontWeight.bold
                    : FontWeight.w500,
          ),
        ),

        Text(
          amount,

          style: TextStyle(
            fontSize: isTotal ? 18 : 15,

            fontWeight:
                isTotal
                    ? FontWeight.bold
                    : FontWeight.w600,

            color: isTotal
                ? AppColors.infoColor
                : Colors.black,
          ),
        ),
      ],
    );
  }
}