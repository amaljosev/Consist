import 'package:consist/core/app_icons.dart';
import 'package:consist/features/habit/presentation/pages/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              Icon(MyFlutterApp.tasks),
              Text('Consist', style: Theme.of(context).textTheme.headlineLarge),
              CupertinoListSection.insetGrouped(
                children: [
                  ListTile(
                    leading: const Icon(Icons.assignment_turned_in_outlined),
                    title: Text('Manage Habits'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.category_rounded),
                    title: Text('Add Categories'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule_folder_outlined),
                    title: Text('Set Frequency Rules'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_center_outlined),
                    title: Text('Help'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_giftcard_outlined),
                    title: Text('Feedback'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_border),
                    title: Text('Rate us'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_center_outlined),
                    title: Text('Privacy Policy'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.card_giftcard_outlined),
                    title: Text('Terms and Conditions'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
              CupertinoListSection.insetGrouped(
                children: [
                  ListTile(
                    leading: const Icon(MyFlutterApp.cog),
                    title: Text('Settings'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen(),)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text('About this app'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.share_outlined),
                    title: Text('Share this app'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
