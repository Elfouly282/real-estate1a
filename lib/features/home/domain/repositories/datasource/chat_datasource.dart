import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/chat_entity.dart';

abstract class ChatDatasource {
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
