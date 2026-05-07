import 'package:dartz/dartz.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/home/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ConversationEntity>> getConversationAndMessage(
    int conversationId,
  );

  Future<Either<Failure, List<ConversationEntity>>> getConversationList();

  Future<Either<Failure, void>> sendMessage(
    int conversationId,
    String message,
  );

  Future<Either<Failure, ConversationEntity>> startConversation(
    int agentUserId,
    int propertyId,
  );
}
