import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chatScreen";
  static const String currentUserId = '13';

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

  Widget _buildBody(ChatState state) {
    if (state is ConversationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ConversationError) {
      return Center(child: Text(state.message));
    }

    if (state is SendMessageError) {
      return Center(child: Text(state.message));
    }

    return Chat(
      chatController: _chatController,
      currentUserId: ChatScreen.currentUserId,
      onMessageSend: (text) async {
        final tempMessage = TextMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          authorId: ChatScreen.currentUserId,
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
          name: id == ChatScreen.currentUserId ? 'Me' : 'Agent',
        );
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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chat')),
          body: _buildBody(state),
        );
      },
    );
  }
}
