import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_colors.dart';
import 'package:viva/features/profile/domain/entities/listener_profile.dart';

class CommunitiesSection extends StatelessWidget {
  final ListenerProfile profile;
  final void Function(CommunityEntity community)? onCommunityTap;

  const CommunitiesSection({
    super.key,
    required this.profile,
    this.onCommunityTap,
  });

  @override
  Widget build(BuildContext context) {
    if (profile.communities.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'My Communities',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Cards Row
          Row(
            children: [
              for (int i = 0; i < profile.communities.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: _buildCommunityCard(
                    community: profile.communities[i],
                    icon: i % 2 == 0
                        ? Icons.people_alt_outlined
                        : Icons.music_note_outlined,
                    gradientColors: i % 2 == 0
                        ? [
                            AppColors.primaryPurple,
                            const Color(0xFF6B25C2),
                          ]
                        : [
                            AppColors.primaryPink,
                            const Color(0xFFB01C6A),
                          ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard({
    required CommunityEntity community,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCommunityTap?.call(community),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Row(
            children: [
              // Icon Box
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryText,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      community.membersCount,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
