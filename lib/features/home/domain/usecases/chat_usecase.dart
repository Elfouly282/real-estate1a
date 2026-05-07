import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/core/errors/failure.dart';
import 'package:real_estate_1a/features/home/domain/repositories/repositories/chat_repository.dart';
import '../entities/chat_entity.dart';

@injectable
class ListConversationUsecase {
  final ChatRepository repository;

  ListConversationUsecase({required this.repository});

  Future<Either<Failure, List<ConversationEntity>>> invoke() =>
      repository.getConversationList();
}

@injectable
class GetConversationAndMessageUseCase {
  final ChatRepository repository;

  GetConversationAndMessageUseCase({required this.repository});

  Future<Either<Failure, ConversationEntity>> invoke(
    int conversationId,
  ) =>
      repository.getConversationAndMessage(conversationId);
}

@injectable
class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<Either<Failure, void>> invoke(
    int conversationId,
    String message,
  ) =>
      repository.sendMessage(conversationId, message);
}

@injectable
class StartConversationUseCase {
  final ChatRepository repository;

  StartConversationUseCase({required this.repository});

  Future<Either<Failure, ConversationEntity>> invoke(
    int agentUserId,
    int propertyId,
  ) =>
      repository.startConversation(agentUserId, propertyId);
}

