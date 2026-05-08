class AppNotification {
  final String? title;
  final String? body;
  final String? type; // chat / property
  final String? id; // chat_id / property_id

  AppNotification({
    this.title,
    this.body,
    this.type,
    this.id,
  });
}