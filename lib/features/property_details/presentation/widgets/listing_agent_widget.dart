import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_1a/features/home/presentation/cubit/chat/chat_cubit.dart';
import 'package:real_estate_1a/features/home/presentation/pages/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/snakbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/entities/property_details_entity.dart';

class ListingAgentWidget extends StatelessWidget {
  final AgentEntity agent;
  int propertyId;

  ListingAgentWidget({
    super.key,
    required this.agent,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is StartConversationSuccess) {
          Navigator.pushNamed(
            context,
            ChatScreen.routeName,
            arguments: state.conversationId,
          );
        }

        if (state is StartConversationError) {
          CustomSnackbar(
            AppColors.errorColor,
            state.message,
            true,
          ).show(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Listing Agent',
              style: getBoldStyle(fontSize: 16, color: AppColors.darkColor),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                _buildAgentInfo(),
                const Spacer(),
                _buildActionIcons(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final agentName = agent.user.name.trim();

    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.grey,
      child: Text(
        agentName.isNotEmpty ? agentName[0].toUpperCase() : 'A',
        style: getBoldStyle(
          fontSize: AppFonts.titleMedium,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildAgentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          agent.user.name,
          style: getMediumStyle(fontSize: 14, color: AppColors.darkColor),
        ),
        const SizedBox(height: 2),
        Text(
          agent.title,
          style: getRegularStyle(
            fontSize: 12,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcons(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          iconPath: Assets.icon.call.path,
          onTap: () async {
            if (agent.user.phone != null) {
              final uri = Uri.parse('tel:${agent.user.phone}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            } else {
              CustomSnackbar(
                AppColors.errorColor,
                'No phone number available',
                true,
              ).show(context);
            }
          },
        ),
        const SizedBox(width: 12),

        /// ✅ FIXED MESSAGE BUTTON
        _buildIconButton(
          iconPath: Assets.icon.message.path,
          onTap: () {
            context.read<ChatCubit>().startConversation(
              agentUserId: agent.user.id,
              propertyId: propertyId,
            );
          },
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(iconPath, height: 28),
      ),
    );
  }
}
