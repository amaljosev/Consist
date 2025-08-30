import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit Analysis"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Completion Summary
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Overall Completion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.7, // replace with calculated value
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(height: 8),
                    const Text("70% completed", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Streak Cards
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          Text("Current Streak", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("5 days 🔥", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          Text("Longest Streak", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("12 days 🌟", style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Weekly Performance Chart
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Weekly Performance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 200, child: WeeklyBarChart()),
                  ],
                ),
              ),
            ),
            const HabitCategoryPieChart(),

            const CompletionRateSection(),
            const CompletionTrendChart(),

          ],
        ),
      ),
    );
  }
}
class HabitCategoryPieChart extends StatelessWidget {
  const HabitCategoryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Habit Category Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 40,
                      title: "Health\n40%",
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 25,
                      title: "Study\n25%",
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: 20,
                      title: "Productivity\n20%",
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.purple,
                      value: 15,
                      title: "Fitness\n15%",
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CompletionTrendChart extends StatelessWidget {
  const CompletionTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "7-Day Completion Trend",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${(value * 100).toInt()}%",
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                        interval: 0.2,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                          if (value.toInt() < days.length) {
                            return Text(
                              days[value.toInt()],
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 1,
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      curveSmoothness: 0.3,
                      spots: const [
                        FlSpot(0, 0.8), 
                        FlSpot(1, 0.6),
                        FlSpot(2, 0.7),
                        FlSpot(3, 0.9),
                        FlSpot(4, 0.5),
                        FlSpot(5, 0.65),
                        FlSpot(6, 0.85), 
                      ],
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: Colors.purple,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [Colors.purple.withOpacity(0.3), Colors.blue.withOpacity(0.1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 7, width: 18)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, width: 18)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 8, width: 18)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 6, width: 18)]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 9, width: 18)]),
          BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 4, width: 18)]),
          BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 7, width: 18)]),
        ],
      ),
    );
  }
}
class CompletionRateCard extends StatelessWidget {
  final String title;
  final double rate; // 0.0 - 1.0

  const CompletionRateCard({
    super.key,
    required this.title,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: rate,
              minHeight: 12,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Text("${(rate * 100).toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
class CompletionRateSection extends StatelessWidget {
  const CompletionRateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CompletionRateCard(
                title: "Today",
                rate: 0.8, // 🔹 replace with today rate from DB
              ),
            ),
            Expanded(
              child: CompletionRateCard(
                title: "Weekly",
                rate: 0.65, // 🔹 replace with weekly rate
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CompletionRateCard(
          title: "Monthly",
          rate: 0.72, // 🔹 replace with monthly rate
        ),
        
      ],
    );
  }
}
