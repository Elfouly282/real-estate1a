import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  static String routeName="/chatScreen";
  final int conversationId;

  const ChatScreen({
    super.key,
    required this.conversationId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = InMemoryChatController();

  @override
  void initState() {
    super.initState();

    context
        .read<ChatCubit>()
        .getConversationAndMessages(widget.conversationId);
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void _loadMessages(ConversationSuccess state) {
    _chatController.setMessages(
      state.conversation.messages?.map((message) {
        return TextMessage(
          id: message.id.toString(),
          authorId: message.sender?.id.toString() ?? '',
          createdAt: DateTime.tryParse(message.createdAt ?? '') ??
              DateTime.now(),
          text: message.body ?? '',
        );
      }).toList() ??
          [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ConversationSuccess) {
          _loadMessages(state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chat')),

          body: state is ConversationLoading
              ? const Center(child: CircularProgressIndicator())
              : Chat(
            chatController: _chatController,
            currentUserId: '13',

            onMessageSend: (text) async {
              final tempMessage = TextMessage(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                authorId: '1',
                createdAt: DateTime.now().toUtc(),
                text: text,
              );

              _chatController.insertMessage(tempMessage);

              await context.read<ChatCubit>().sendMessage(
                conversationId: widget.conversationId,
                message: text,
              );
            },

            resolveUser: (UserID id) async {
              return User(
                id: id,
                name: id == '13' ? 'Me' : 'Agent',
              );
            },
          ),
        );
      },
    );
  }
}