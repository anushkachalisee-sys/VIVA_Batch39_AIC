import 'package:flutter/material.dart';
import 'package:viva/core/constants/app_color.dart';

class ProfileBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const ProfileBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: AppColors.mainBackground,
        border: const Border(
          top: BorderSide(
            color: Color(0xFF1F1D38),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            label: 'Home',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          _buildNavItem(
            index: 1,
            label: 'Discover',
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
          ),
          _buildNavItem(
            index: 2,
            label: 'Events',
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
          ),
          _buildNavItem(
            index: 3,
            label: 'Community',
            icon: Icons.people_outline,
            activeIcon: Icons.people,
          ),
          _buildNavItem(
            index: 4,
            label: 'Profile',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTabSelected(index),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container (with subtle purple circular background for selected item)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryPurple.withValues(alpha: 0.3)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? AppColors.cyanAccent : AppColors.textMuted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 2),

              // Label Text
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? AppColors.cyanAccent : AppColors.textMuted,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
