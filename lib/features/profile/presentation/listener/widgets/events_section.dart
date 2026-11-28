import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
import 'package:viva/features/profile/domain/entities/listener_profile.dart';

class EventsSection extends StatelessWidget {
  final ListenerProfile profile;
  final void Function(EventEntity event)? onEventTap;

  const EventsSection({
    super.key,
    required this.profile,
    this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    if (profile.upcomingEvents.isEmpty) return const SizedBox.shrink();
    final event = profile.upcomingEvents.first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Events',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${profile.upcomingEvents.length} UPCOMING',
                style: const TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Event Card
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onEventTap?.call(event),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                ),
                child: Row(
                  children: [
                    // Event Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 54,
                        height: 54,
                        child: event.imageUrl.isNotEmpty
                            ? Image.asset(
                                event.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildEventImagePlaceholder();
                                },
                              )
                            : _buildEventImagePlaceholder(),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Date Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryPink.withValues(alpha: 0.8),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            event.month,
                            style: const TextStyle(
                              color: AppColors.primaryPink,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            event.day,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Event Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            event.title,
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
                            event.location,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            event.status,
                            style: const TextStyle(
                              color: AppColors.accentCyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    const Icon(
                      Icons.north_east,
                      color: AppColors.accentCyan,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventImagePlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF3A1C71),
            Color(0xFFD76D77),
            Color(0xFFFFAF7B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.headset,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
