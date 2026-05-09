import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/security/security_helper.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chatScreen";

  final int conversationId;

  const ChatScreen({super.key, required this.conversationId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = InMemoryChatController();

  String get _currentUserId => getIt<AuthStorage>().userId ?? '';

  @override
  void initState() {
    super.initState();

    context.read<ChatCubit>().getConversationAndMessages(widget.conversationId);
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _loadMessages(ConversationSuccess state) {
    final messages = state.conversation.messages ?? [];

    final mappedMessages = messages.map((message) {
      return TextMessage(
        id: message.id.toString(),
        authorId: message.sender?.id.toString() ?? '',
        createdAt: DateTime.tryParse(message.createdAt ?? '') ?? DateTime.now(),
        text: message.body ?? '',
      );
    }).toList();

    _chatController.setMessages(mappedMessages);
  }

  Widget _buildBody(ChatState state) {
    if (state is ConversationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ConversationError) {
      return Center(child: Text(state.message));
    }

    return Chat(
      chatController: _chatController,
      currentUserId: _currentUserId,
      onMessageSend: (text) async {
        final tempMessage = TextMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          authorId: _currentUserId,
          createdAt: DateTime.now().toUtc(),
          text: text,
        );

        _chatController.insertMessage(tempMessage);
        context.read<ChatCubit>().sendMessage(
          conversationId: widget.conversationId,
          message: text,
        );
      },
      resolveUser: (UserID id) async {
        return User(id: id, name: id == _currentUserId ? 'Me' : 'Agent');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ConversationSuccess) {
          _loadMessages(state);
        }

        if (state is SendMessageError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chat'), centerTitle: true),
          body: _buildBody(state),
        );
      },
    );
  }
}
