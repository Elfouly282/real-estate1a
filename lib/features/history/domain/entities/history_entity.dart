import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

// ── Order Entity ──────────────────────────────────────────────────────────────

class OrderEntity {
  final int id;
  final double amount;
  final String currency;
  final String status; // "pending" | "completed" | "cancelled"
  final String? stripeCheckoutSessionId;
  final DateTime createdAt;
  final PropertyEntity property;

  const OrderEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    this.stripeCheckoutSessionId,
    required this.createdAt,
    required this.property,
  });

  // ── Helpers ────────────────────────────────────────────────────────────────

  String get formattedAmount {
    if (amount >= 1000000) return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '\$${(amount / 1000).toStringAsFixed(0)}K';
    return '\$${amount.toStringAsFixed(0)}';
  }

  String get statusLabel {
    switch (status) {
      case 'completed': return 'Completed';
      case 'cancelled': return 'Cancelled';
      case 'pending':   return 'Pending';
      default:          return status;
    }
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
}

// ── History Entity ────────────────────────────────────────────────────────────

class HistoryEntity {
  final List<OrderEntity> orders;
  final int currentPage;
  final int lastPage;
  final int total;

  const HistoryEntity({
    required this.orders,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  bool get hasMore => currentPage < lastPage;
}