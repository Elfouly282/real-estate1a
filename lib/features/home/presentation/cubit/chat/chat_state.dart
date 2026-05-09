part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}


class ConversationsLoading extends ChatState {}

class ConversationsSuccess extends ChatState {
  final List<ConversationEntity> conversations;

  ConversationsSuccess(this.conversations);
}

class ConversationsError extends ChatState {
  final String message;

  ConversationsError(this.message);
}


class ConversationLoading extends ChatState {}

class ConversationSuccess extends ChatState {
  final ConversationEntity conversation;

  ConversationSuccess(this.conversation);
}

class ConversationError extends ChatState {
  final String message;

  ConversationError(this.message);
}

class SendMessageLoading extends ChatState {}

class SendMessageSuccess extends ChatState {}

class SendMessageError extends ChatState {
  final String message;

  SendMessageError(this.message);
}


class StartConversationLoading extends ChatState {}

class StartConversationSuccess extends ChatState {
  final int conversationId;

  StartConversationSuccess(this.conversationId);
}

class StartConversationError extends ChatState {
  final String message;

  StartConversationError(this.message);
}