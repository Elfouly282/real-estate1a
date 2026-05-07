import 'package:real_estate_1a/features/home/domain/entities/home_response_entity.dart';

class ChatEntity {
  ChatEntity({
      this.conversations,});

  ConversationEntity? conversations;
}

class ConversationEntity {
  ConversationEntity({
      this.id, 
      this.user, 
      this.agentUser, 
      this.property,
      this.messages,
      this.updatedAt,});

  num? id;
  UserEntity? user;
  AgentEntity? agentUser;
  PropertyEntity? property;
  String? updatedAt;
  List<MessagesEntity>? messages;

  Object? operator [](int other) {}

}
class MessagesEntity {
  MessagesEntity({
    this.id,
    this.body,
    this.readAt,
    this.createdAt,
    this.sender,});

  num? id;
  String? body;
  dynamic readAt;
  String? createdAt;
  SenderEntity? sender;
}
class SenderEntity {
  SenderEntity({
    this.id,
    this.name,
    this.email,
    this.role,
    this.location,
    this.phone,
    this.createdAt,});
  num? id;
  String? name;
  String? email;
  String? role;
  dynamic location;
  dynamic phone;
  String? createdAt;


}
