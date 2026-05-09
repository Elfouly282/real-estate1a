import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_1a/features/home/domain/entities/chat_entity.dart';
import 'package:real_estate_1a/features/home/domain/usecases/chat_usecase.dart';
part 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ListConversationUsecase listConversationUsecase;
  final GetConversationAndMessageUseCase getConversationAndMessageUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final StartConversationUseCase startConversationUseCase;

  ChatCubit({
    required this.listConversationUsecase,
    required this.getConversationAndMessageUseCase,
    required this.sendMessageUseCase,
    required this.startConversationUseCase,
  }) : super(ChatInitial());

  List<ConversationEntity> conversations = [];
  List<MessagesEntity> messages = [];

  ConversationEntity? currentConversation;

  int? currentConversationId;

  Future<void> getConversations() async {
    emit(ConversationsLoading());

    final result = await listConversationUsecase.invoke();

    result.fold(
          (failure) => emit(ConversationsError(failure.message)),
          (data) {
        conversations = data;
        emit(ConversationsSuccess(data));
      },
    );
  }

  Future<void> getConversationAndMessages(int conversationId) async {
    currentConversationId = conversationId;

    emit(ConversationLoading());

    final result =
    await getConversationAndMessageUseCase.invoke(conversationId);

    result.fold(
          (failure) => emit(ConversationError(failure.message)),
          (data) {
        currentConversation = data;
        messages = data.messages ?? [];
        emit(ConversationSuccess(data));
      },
    );
  }

  Future<void> sendMessage({
    required int conversationId,
    required String message,
  }) async {
    if (message.trim().isEmpty) return;

    final result = await sendMessageUseCase.invoke(
      conversationId,
      message,
    );

    result.fold(
          (failure) => emit(SendMessageError(failure.message)),
          (_) async {
        emit(SendMessageSuccess());
        await getConversationAndMessages(conversationId);
      },
    );
  }

  Future<void> startConversation({
    required int agentUserId,
    required int propertyId,
  }) async {
    emit(StartConversationLoading());

    final result = await startConversationUseCase.invoke(
      agentUserId,
      propertyId,
    );

    result.fold(
          (failure) => emit(StartConversationError(failure.message)),
          (data) {
        final conversationId = data.id?.toInt();

        if (conversationId == null) {
          emit(StartConversationError('Conversation id not found'));
          return;
        }

        emit(StartConversationSuccess(conversationId));
      },
    );
  }

  List<MessagesEntity> get uiMessages => messages;
}