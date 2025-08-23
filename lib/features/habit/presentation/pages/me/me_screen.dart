import 'package:consist/core/app_colors.dart';
import 'package:consist/features/habit/presentation/pages/me/widgets/achievements_widget.dart';
import 'package:consist/features/habit/presentation/pages/routine/widgets/drawer_home.dart';
import 'package:consist/features/habit/presentation/widgets/calender_widget.dart';
import 'package:flutter/material.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      endDrawer: DrawerHome(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.blue,
                child: Icon(Icons.person_outline, size: 60),
              ),
              Text(
                'Username',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              UserAchievementWidget(),
              ClipRSuperellipse(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
                child: CalenderWidget(isHome: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
