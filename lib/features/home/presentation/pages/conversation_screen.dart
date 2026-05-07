import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/features/home/presentation/pages/home_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/chat_entity.dart';
import '../cubit/chat/chat_cubit.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  static const String routeName = "/conversations";

  const ConversationsScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
     leading:  IconButton(icon: Icon(Icons.arrow_back),onPressed: (){Navigator.pushNamed(context, HomeScreen.routeName);},),
        title: const Text("Conversations"),
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

            return ListView.builder(
              itemCount: conversations.length,

              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person,color: AppColors.primaryColor,),
                  ),

                  title: Text(
                    conversation.user?.name ?? '',
                  ),

                  subtitle: Text(
                    (conversation.messages?.isNotEmpty ?? false)
                        ? conversation.messages!.last.body ?? ''
                        : 'No messages yet',
                  ),

                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ChatScreen.routeName,
                      arguments: conversation.id ?? 0,
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}