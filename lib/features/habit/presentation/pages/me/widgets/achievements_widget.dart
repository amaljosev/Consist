
import 'package:flutter/material.dart';

class UserAchievementWidget extends StatelessWidget {
  const UserAchievementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAchievements(
          value: '12',
          title: 'Stars Earned',
          icon: Icons.star_border,
        ),
        UserAchievements(
          value: '32',
          title: 'Best Streak',
          icon: Icons.local_fire_department_outlined,
        ),
        UserAchievements(
          value: '10',
          title: 'Habits Gained',
          icon: Icons.flag_outlined,
        ),
      ],
    );
  }
}

class UserAchievements extends StatelessWidget {
  const UserAchievements({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
  });
  final String value;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Icon(icon),
            ],
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}