import 'package:consist/core/app_colors.dart';
import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/pages/routine/widgets/new_routine_sheet.dart';
import 'package:consist/features/habit/presentation/widgets/calender_widget.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            expandedHeight: size.height * 0.1,
            backgroundColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                isDark
                    ? 'assets/img/dashboard_dark.png'
                    : 'assets/img/dashboard_light.png',
                fit: BoxFit.cover,
              ),
              expandedTitleScale: 1.0,
              stretchModes: [StretchMode.zoomBackground],
            ),
            title: Text('Small steps, big results. Keep going!'),
            titleTextStyle: Theme.of(context).textTheme.headlineSmall,
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
          ),
        ],
        body: Column(
          children: [
            Container(
              color: !isDark
                  ? const Color.fromARGB(177, 10, 182, 164)
                  : const Color.fromARGB(255, 13, 56, 141),
              child:const CalenderHomeWidget(),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  Color color = AppColors.myColorsDarker[index];
                  Color colorD = AppColors.myColors[index];
                  final habit = HabitsItems.habitsToDevelop[index];
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: isDark ? color.withValues(alpha: 0.2) : colorD,
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: color.withValues(alpha: 0.5),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(habit['icon'], color: Colors.white),
                        ),
                      ),
                      title: Text(habit['name']),
                      trailing: CircleAvatar(
                        radius: 16,
                        backgroundColor: color.withValues(alpha: 0.5),
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: HabitsItems.habitsToDevelop.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: NewRoutine(isDark: isDark),
    );
  }
}
