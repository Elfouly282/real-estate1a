import 'package:real_estate_1a/features/home/data/models/home_response_model.dart';
import 'package:real_estate_1a/features/home/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({required super.conversations});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      conversations: json['data'] != null
          ? DataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": (conversations as DataModel?)?.toJson(),
    };
  }
}
class DataModel extends ConversationEntity {
  DataModel({
    required super. id,
    required super. user,
   required super. agentUser,
   required super. property,
   required super. updatedAt,
   required super. messages,
  }) ;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
      agentUser: json['agent_user'] != null
          ? AgentModel.fromJson(json['agent_user'])
          : null,
      property: json['property'] != null
          ? PropertyModel.fromJson(json['property'])
          : null,
      updatedAt: json['updated_at'],
      messages: json['messages'] != null
          ? List<MessagesModel>.from(
        json['messages'].map((e) => MessagesModel.fromJson(e)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user": (user as UserModel?)?.toJson(),
      "agent_user": (agentUser as AgentModel?)?.toJson(),
      "property": (property as PropertyModel?)?.toJson(),
      "updated_at": updatedAt,
      "messages": (messages as List<MessagesModel>?)
          ?.map((e) => e.toJson())
          .toList(),
    };
  }

}
class MessagesModel extends MessagesEntity {
  MessagesModel({
    required super.id,
    required super.body,
    required super.readAt,
    required super.createdAt,
    required super.sender,
  }) ;

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json['id'],
      body: json['body'],
      readAt: json['read_at'],
      createdAt: json['created_at'],
      sender: json['sender'] != null
          ? SenderModel.fromJson(json['sender'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "body": body,
      "read_at": readAt,
      "created_at": createdAt,
      "sender": (sender as SenderModel?)?.toJson(),
    };
  }
}class SenderModel extends SenderEntity {
  SenderModel({
    required super. id,
required super. name,
   required super. email,
 required super. role,
  required super. location,
 required super. phone,
  required super.createdAt,
  }) ;
  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      location: json['location'],
      phone: json['phone'],
      createdAt: json['created_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "location": location,
      "phone": phone,
      "created_at": createdAt,
    };
  }
}