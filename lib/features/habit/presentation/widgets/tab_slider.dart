import 'package:flutter/material.dart';

class TabSliderWidget extends StatelessWidget {
  const TabSliderWidget({
    super.key,
    required this.isDark,
    required this.tab1,
    required this.tab2,
    required this.tab3,
    required this.controller,
  });

  final bool isDark;
  final String tab1;
  final String tab2;
  final String tab3;
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? Colors.white10 : Colors.white38,
      elevation: 0,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: isDark
              ? Theme.of(context).colorScheme.onSurface
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 6.0,
                offset: Offset(4, 4),
                spreadRadius: 1,
              ),
          ],
        ),
        splashBorderRadius: const BorderRadius.all(Radius.circular(20)),
        indicatorPadding: const EdgeInsets.all(5),
        labelStyle: isDark
            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            : Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),

        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: isDark ? null : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),

        tabs: [
          SizedBox(width: 80, child: Tab(text: tab1)),
          SizedBox(width: 80, child: Tab(text: tab2)),
          SizedBox(width: 80, child: Tab(text: tab3)),
        ],
      ),
    );
  }
}
