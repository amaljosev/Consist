import 'package:consist/features/habit/presentation/blocs/habits_bloc/habits_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class HabitAnalyticsScreen extends StatefulWidget {
  final String habitId;
  const HabitAnalyticsScreen({super.key, required this.habitId});

  @override
  State<HabitAnalyticsScreen> createState() => _HabitAnalyticsScreenState();
}

class _HabitAnalyticsScreenState extends State<HabitAnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HabitsBloc>().add(FetchHabitAnalyticsEvent(widget.habitId));
  }

  // Count frequency of days (1=Mon ... 7=Sun)
  Map<int, int> _countDaysFrequency(List<int> days) {
    final countMap = <int, int>{};
    for (var d = 1; d <= 7; d++) {
      countMap[d] = 0;
    }
    for (var day in days) {
      if (countMap.containsKey(day)) {
        countMap[day] = (countMap[day] ?? 0) + 1;
      }
    }
    return countMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Habit Analytics'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<HabitsBloc>().add(LoadHabitsEvent());
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state is HabitAnalyticsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitAnalyticsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is HabitAnalyticsLoaded) {
            final analytics = state.analytics;

            if (analytics == null) {
              return const Center(
                child: Text('No analytics found for this habit.'),
              );
            }

            final dayCounts = _countDaysFrequency(analytics.mostActiveDays);
            final maxDayCount = dayCounts.values.isEmpty
                ? 1
                : dayCounts.values.reduce((a, b) => a > b ? a : b);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Last Day Done Section
                  _buildSectionHeader("📅 Last Habit Done"),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: _modernCardDecoration(),
                    child: Text(
                      analytics.lastDay.isNotEmpty
                          ? analytics.lastDay
                          : 'No records yet',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Summary Stats Cards
                  _buildSectionHeader("🔥 Key Stats"),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.local_fire_department,
                          title: "Current Streak",
                          value: analytics.currentStreak.toString(),
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star,
                          title: "Best Streak",
                          value: analytics.bestStreak.toString(),
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.emoji_events,
                          title: "Stars Earned",
                          value: analytics.starsEarned.toString(),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Completion Rates Chart
                  _buildSectionHeader("📊 Completion Rates"),
                  const SizedBox(height: 16),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(16),
                    decoration: _modernCardDecoration(),
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const labels = [
                                  'Overall',
                                  'Week',
                                  'Month',
                                  'Year',
                                ];
                                if (value.toInt() >= 0 &&
                                    value.toInt() < labels.length) {
                                  return Text(
                                    labels[value.toInt()],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barGroups: [
                          _buildBarGroup(
                            0,
                            analytics.completionRate,
                            Colors.indigoAccent,
                          ),
                          _buildBarGroup(
                            1,
                            analytics.weeklyCompletionRate,
                            Colors.tealAccent.shade700,
                          ),
                          _buildBarGroup(
                            2,
                            analytics.monthlyCompletionRate,
                            Colors.orange.shade400,
                          ),
                          _buildBarGroup(
                            3,
                            analytics.yearlyCompletionRate,
                            Colors.red,
                          ),
                        ],
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 800),
                      swapAnimationCurve: Curves.easeOutCubic,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Most Active Days as Bar Chart
                  _buildSectionHeader("📅 Most Active Days"),
                  const SizedBox(height: 12),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(16),
                    decoration: _modernCardDecoration(),
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxDayCount.toDouble() + 1,
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const labels = [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun',
                                ];
                                if (value.toInt() >= 0 &&
                                    value.toInt() < labels.length) {
                                  return Text(
                                    labels[value.toInt()],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barGroups: List.generate(7, (index) {
                          final dayIndex = index + 1;
                          final count = dayCounts[dayIndex]?.toDouble() ?? 0;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: count,
                                color: Colors.indigoAccent,
                                width: 20,
                                borderRadius: BorderRadius.circular(6),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: maxDayCount.toDouble() + 1,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 800),
                      swapAnimationCurve: Curves.easeOutCubic,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Achievements Section
                  _buildSectionHeader("🏆 Achievements"),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: analytics.achievements.isEmpty
                        ? [const Chip(label: Text('No achievements yet'))]
                        : analytics.achievements
                              .map(
                                (a) => Chip(
                                  label: Text("Achievement #$a"),
                                  backgroundColor: Colors.green.shade50,
                                  avatar: const Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                              .toList(),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Loading analytics...'));
        },
      ),
    );
  }

  // Modern Stat Card widget
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _modernCardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  // Section header widget
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // Bar chart group helper
  BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 22,
          borderRadius: BorderRadius.circular(6),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  // Card decoration with shadow & rounded corners
  BoxDecoration _modernCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
      ],
    );
  }
}
