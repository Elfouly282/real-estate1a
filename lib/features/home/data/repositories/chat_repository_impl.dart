import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/home/domain/entities/chat_entity.dart';
import 'package:real_estate_1a/features/home/domain/repositories/datasource/chat_datasource.dart';
import 'package:real_estate_1a/features/home/domain/repositories/repositories/chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  late final ChatDatasource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, ConversationEntity>> getConversationAndMessage(
    int conversationId,
  ) {
    return datasource.getConversationAndMessage(conversationId);
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversationList() =>
      datasource.getConversationList();

  @override
  Future<Either<Failure, void>> sendMessage(
    int conversationId,
    String message,
  ) =>
      datasource.sendMessage(conversationId, message);

  @override
  Future<Either<Failure, ConversationEntity>> startConversation(
    int agentUserId,
    int propertyId,
  ) =>
      datasource.startConversation(agentUserId, propertyId);
}
