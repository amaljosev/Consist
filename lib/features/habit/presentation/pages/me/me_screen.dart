import 'package:consist/features/habit/presentation/pages/me/widgets/achievements_widget.dart';
import 'package:consist/features/habit/presentation/pages/goals/widgets/drawer_home.dart';
import 'package:flutter/material.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      endDrawer: DrawerHome(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Card(
                elevation: 0,
                child: SizedBox(
                  height: size.height * 0.1,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Row(
                          spacing: 5,
                          children: [
                            Text(
                              'S7LD7FH5E5OTY9W56348',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            Icon(
                              Icons.copy,
                              color: Colors.grey,
                              size: size.width * 0.04,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              UserAchievementWidget(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                  ),

                  itemBuilder: (context, index) => meCategories(
                    icon: Icons.today_outlined,
                    title: 'My Goals',
                  ),
                  itemCount: 4,
                ),
              ),
              // ClipRSuperellipse(
              //   borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
              //   child: CalenderWidget(isHome: false),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget meCategories({required IconData icon, required String title}) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            Icon(icon),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
