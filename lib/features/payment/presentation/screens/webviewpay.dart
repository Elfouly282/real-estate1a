import 'package:flutter/material.dart';
import 'package:real_estate_1a/core/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  static const String routeName = "/paymentWebView";

  final String paymentUrl;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
  });

  @override
  State<PaymentWebViewScreen> createState() =>
      _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState
    extends State<PaymentWebViewScreen> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.paymentUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Pay Now",style: TextStyle(
          color: AppColors.infoColor
          
        ),),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}