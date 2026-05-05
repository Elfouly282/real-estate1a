import 'package:real_estate_1a/features/history/domain/entities/history_entity.dart';
import 'package:real_estate_1a/features/home/data/models/home_response_model.dart';

// ── Order Model ───────────────────────────────────────────────────────────────

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.amount,
    required super.currency,
    required super.status,
    super.stripeCheckoutSessionId,
    required super.createdAt,
    required super.property,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id:       json['id'] as int,
    amount:   double.parse(json['amount'].toString()),
    currency: json['currency'] as String,
    status:   json['status'] as String,
    stripeCheckoutSessionId:
    json['stripe_checkout_session_id'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    property: PropertyModel.fromJson(
        json['property'] as Map<String, dynamic>),
  );
}

// ── History Model ─────────────────────────────────────────────────────────────

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.orders,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;

    return HistoryModel(
      orders: data
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: meta['current_page'] as int,
      lastPage:    meta['last_page'] as int,
      total:       meta['total'] as int,
    );
  }
}