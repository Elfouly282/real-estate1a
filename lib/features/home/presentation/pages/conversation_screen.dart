import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:real_estate_1a/core/constant/custom_svg_image.dart';
import 'package:real_estate_1a/gen/assets.gen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../main.dart';
import '../../domain/entities/chat_entity.dart';
import '../cubit/chat/chat_cubit.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  static const String routeName = "/conversations";

  final int? agentUserId;
  final int? propertyId;

  const ConversationsScreen({
    super.key,
    this.agentUserId,
    this.propertyId,
  });

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getConversations();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> startConversation() async {
      final agentUserId = widget.agentUserId;
      final propertyId = widget.propertyId;

      if (agentUserId == null || propertyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Open a property first to start a conversation.'),
          ),
        );
        return;
      }

      await context.read<ChatCubit>().startConversation(
            agentUserId: agentUserId,
            propertyId: propertyId,
          );
    }

    Widget buildConversationList(List<ConversationEntity> conversations) {
      if (conversations.isEmpty) {
        return const Center(child: Text('No conversations yet'));
      }

      return ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];

          return ListTile(
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
            ),
            title: Text(
              conversation.user?.name ?? '',
            ),
            subtitle: Text(
              (conversation.messages?.isNotEmpty ?? false)
                  ? conversation.messages!.last.body ?? ''
                  : 'No messages yet',
            ),
            onTap: () async {
              final conversationId = conversation.id?.toInt();

              if (conversationId == null) {
                return;
              }

              await Navigator.pushNamed(
                context,
                ChatScreen.routeName,
                arguments: conversationId,
              );

              if (!context.mounted) {
                return;
              }

              context.read<ChatCubit>().getConversations();
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Conversations"),
        actions: [
          InkWell(child: CustomSvgImage(path: Assets.svg.activeNotification),onTap: () async{
            const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              'default_channel',
              'Default',
              importance: Importance.max,
              priority: Priority.max,
            );

            const NotificationDetails details =
            NotificationDetails(android: androidDetails);

            await fln.show(
              1,
              'Test Notification 🔔',
              'This is a local test',
              details,
            );
          },)
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {

          if (state is ConversationsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is ConversationsError) {
            return Center(child: Text(state.message));
          }

          if (state is ConversationsSuccess) {

            final List<ConversationEntity> conversations =
                state.conversations;

            return buildConversationList(conversations);
          }

          final cachedConversations = context.read<ChatCubit>().conversations;

          if (cachedConversations.isNotEmpty) {
            return buildConversationList(cachedConversations);
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is StartConversationSuccess) {
            Navigator.pushNamed(
              context,
              ChatScreen.routeName,
              arguments: state.conversationId,
            );
          }

          if (state is StartConversationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is StartConversationLoading;

          return FloatingActionButton.extended(
            backgroundColor: AppColors.primaryColor,
            onPressed: isLoading ? null : startConversation,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.add_comment),
            label: Text(isLoading ? 'Starting...' : 'Start chat'),
          );

        },
      ),

    );
  }
}
