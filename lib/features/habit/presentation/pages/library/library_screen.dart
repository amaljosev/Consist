import 'package:consist/core/app_colors.dart';
import 'package:consist/core/constants/habits_items.dart';
import 'package:consist/features/habit/presentation/widgets/tab_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            backgroundColor: Theme.of(context).colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    isDark
                        ? 'assets/img/library_night.png'
                        : 'assets/img/library.png',
                    fit: BoxFit.cover,
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Library',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              expandedTitleScale: 1.0,
              stretchModes: [StretchMode.zoomBackground],
              title: TabSliderWidget(

                controller: _tabController,
                isDark: isDark,
                tab1: 'Develop',
                tab2: 'Quit',
                tab3: 'One-time',
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
               
                  final lightColorData = AppColors.myColorsDarker[index];
                  Color color=lightColorData['color'];
                  
                final habit = HabitsItems.habitsToDevelop[index];
                return ListTile(
                  leading: Icon(habit['icon'], color: color),
                  title: Text(habit['name']),
                  trailing: CupertinoListTileChevron(),
                );
              },
              itemCount: HabitsItems.habitsToDevelop.length,
            ),
            ListView.builder(
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
               
                  final lightColorData = AppColors.myColors[index];
                  Color lightColor=lightColorData['color'];
                  
                final habit = HabitsItems.habitsToQuit[index];
                return ListTile(
                  leading: Icon(habit['icon'], color: lightColor),
                  title: Text(habit['name']),
                  trailing: CupertinoListTileChevron(),
                );
              },
              itemCount: HabitsItems.habitsToQuit.length,
            ),
            ListView.builder(
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
               
                  final lightColorData = AppColors.myColors[index];
                  Color lightColor=lightColorData['color'];
                  
                final habit = HabitsItems.singleTimeTasks[index];
                return ListTile(
                  leading: Icon(habit['icon'], color: lightColor),
                  title: Text(habit['name']),
                  trailing: CupertinoListTileChevron(),
                );
              },
              itemCount: HabitsItems.singleTimeTasks.length,
            ),
          ],
        ),
      ),
    );
  }
}


// DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // SliverAppBar(
            //   expandedHeight: size.height * 0.25,
            //   backgroundColor: Theme.of(context).colorScheme.surface,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Stack(
            //       fit: StackFit.expand,
            //       alignment: Alignment.topCenter,
            //       children: [
            //         Image.asset(
            //           isDark
            //               ? 'assets/img/library_night.png'
            //               : 'assets/img/library.png',
            //           fit: BoxFit.cover,
            //         ),
            //         SafeArea(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Library',
            //                 style: Theme.of(context).textTheme.headlineLarge,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //     expandedTitleScale: 1.0,
            //     stretchModes: [StretchMode.zoomBackground],
            //     title: Card(
            //       color: isDark ? Colors.white10 : Colors.white38,
            //       elevation: 0,

            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //       ),
            //       child: TabBar(
            //         indicatorSize: TabBarIndicatorSize.tab,
            //         dividerColor: Colors.transparent,
            //         indicator: BoxDecoration(
            //           color: isDark
            //               ? Theme.of(context).colorScheme.onSurface
            //               : Colors.white,
            //           borderRadius: const BorderRadius.all(Radius.circular(20)),
            //           boxShadow: [
            //             if (!isDark)
            //               BoxShadow(
            //                 color: Colors.grey.shade400,
            //                 blurRadius: 6.0,
            //                 offset: Offset(4, 4),
            //                 spreadRadius: 1,
            //               ),
            //           ],
            //         ),
            //         splashBorderRadius: const BorderRadius.all(
            //           Radius.circular(20),
            //         ),
            //         indicatorPadding: const EdgeInsets.all(5),
            //         labelStyle: isDark
            //             ? Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //               )
            //             : Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                 fontWeight: FontWeight.bold,
            //               ),
            //         unselectedLabelStyle: Theme.of(context)
            //             .textTheme
            //             .bodyMedium!
            //             .copyWith(color: isDark ? null : Colors.grey.shade700,fontWeight: FontWeight.bold,),

            //         tabs: const [
            //           SizedBox(width: 80, child: Tab(text: 'Develop')),
            //           SizedBox(width: 80, child: Tab(text: 'Quit')),
            //           SizedBox(width: 80, child: Tab(text: 'One-time')),
            //         ],
            //       ),
            //     ),
            //   ),
            //   pinned: true,
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            // ),
//           ],
//           body: TabBarView(
//             children: [
              // ListView.builder(
              //   itemBuilder: (context, index) {
              //     final habit = HabitsItems.habitsToDevelop[index];
              //     return ListTile(
              //       leading: Icon(
              //         habit['icon'],
              //         color: AppColors.myColorsDarker[index],
              //       ),
              //       title: Text(habit['name']),
              //       trailing: const CupertinoListTileChevron(),
              //     );
              //   },
              //   itemCount: HabitsItems.habitsToDevelop.length,
              // ),
              // ListView.builder(
              //   itemBuilder: (context, index) {
              //     final habit = HabitsItems.habitsToQuit[index];
              //     return ListTile(
              //       leading: Icon(
              //         habit['icon'],
              //         color: AppColors.myColorsDarker[index],
              //       ),
              //       title: Text(habit['name']),
              //       trailing: const CupertinoListTileChevron(),
              //     );
              //   },
              //   itemCount: HabitsItems.habitsToDevelop.length,
              // ),
//               ListView.builder(
//                 itemBuilder: (context, index) {
//                   final habit = HabitsItems.singleTimeTasks[index];
//                   return ListTile(
//                     leading: Icon(
//                       habit['icon'],
//                       color: AppColors.myColorsDarker[index],
//                     ),
//                     title: Text(habit['name']),
//                     trailing: const CupertinoListTileChevron(),
//                   );
//                 },
//                 itemCount: HabitsItems.habitsToDevelop.length,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );