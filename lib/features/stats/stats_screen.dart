import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/navigation/app_tab_navigation.dart';
import '../../shared/widgets/app_tab_scaffold.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final palette = _selectedTabIndex == 0
        ? const _StatsPalette(
            accent: Color(0xFF2F80ED),
            secondary: Color(0xFF22C55E),
            tertiary: Color(0xFF1D4ED8),
          )
        : const _StatsPalette(
            accent: Color(0xFF8B5CF6),
            secondary: Color(0xFF14B8A6),
            tertiary: Color(0xFF6366F1),
          );
    final content = _selectedTabIndex == 0
        ? const _StatsContent(
            subtitle: 'Overview',
            primaryLabel: 'Tasks today',
            completedLabel: 'Completed today',
            heatmapTitle: 'Daily Progress Heatmap',
            progressValue: 8,
            totalValue: 12,
            dateRangeLabel: 'Oct 23 - Oct 29',
            monthLabel: 'October 2023',
            heatmapValues: [0.35, 0.75, 0.9, 0.5, 0.0, 0.8, 0.65, 0.3, 0.95, 0.7, 0.55, 0.2, 0.85, 0.6],
            weeklyValues: [4, 5, 7, 6, 8, 5, 9],
            monthlyValues: [7, 9, 11, 8, 12, 10],
          )
        : const _StatsContent(
            subtitle: 'Overview',
            primaryLabel: 'Routines today',
            completedLabel: 'Completed today',
            heatmapTitle: 'Daily Progress Heatmap',
            progressValue: 5,
            totalValue: 9,
            dateRangeLabel: 'Oct 23 - Oct 29',
            monthLabel: 'October 2023',
            heatmapValues: [0.2, 0.55, 0.7, 0.9, 0.4, 0.8, 0.65, 0.3, 0.85, 0.75, 0.45, 0.6, 0.95, 0.5],
            weeklyValues: [3, 4, 6, 5, 7, 6, 8],
            monthlyValues: [5, 7, 8, 6, 9, 8],
          );

    final completionRatio = content.totalValue == 0
        ? 0.0
        : content.progressValue / content.totalValue;

    return AppTabScaffold(
      currentTab: AppTab.stats,
      onTabSelected: (selected) {
        navigateFromTabSelection(
          context,
          currentTab: AppTab.stats,
          selectedTab: selected,
        );
      },
      backgroundColor: const Color(0xFF020B1F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistics',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 24),
              _StatsToggle(
                selectedIndex: _selectedTabIndex,
                onChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              const SizedBox(height: 26),
              Text(
                'Daily Stats',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatsSummaryCard(
                      title: 'Progress',
                      value: '${content.progressValue} / ${content.totalValue}',
                      subtitle: content.primaryLabel,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _StatsCompletionCard(
                      title: 'Completion',
                      percentLabel: '${(completionRatio * 100).round()}%',
                      progress: completionRatio,
                      color: palette.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _SectionHeader(title: content.heatmapTitle),
              const SizedBox(height: 16),
              _DailyProgressHeatmap(
                values: content.heatmapValues,
                accent: palette.accent,
                secondary: palette.secondary,
                tertiary: palette.tertiary,
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                title: 'Weekly Stats',
                trailing: content.dateRangeLabel,
              ),
              const SizedBox(height: 16),
              _ChartCard(
                child: _WeeklyLineChart(
                  values: content.weeklyValues,
                  accent: palette.accent,
                ),
              ),
              const SizedBox(height: 28),
              _SectionHeader(
                title: 'Monthly Stats',
                trailing: content.monthLabel,
                trailingColor: palette.accent,
              ),
              const SizedBox(height: 16),
              _ChartCard(
                child: _MonthlyBarChart(
                  values: content.monthlyValues,
                  accent: palette.accent,
                  secondary: palette.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsToggle extends StatelessWidget {
  const _StatsToggle({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const labels = ['Tasks', 'Routines'];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF101827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF17243B)),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2F80ED) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.trailing,
    this.trailingColor,
  });

  final String title;
  final String? trailing;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: trailingColor ?? Colors.white38,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}

class _StatsSummaryCard extends StatelessWidget {
  const _StatsSummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF161E2B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white38,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCompletionCard extends StatelessWidget {
  const _StatsCompletionCard({
    required this.title,
    required this.percentLabel,
    required this.progress,
    required this.color,
  });

  final String title;
  final String percentLabel;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF161E2B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white38,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  percentLabel,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 4,
              backgroundColor: const Color(0xFF253247),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyProgressHeatmap extends StatelessWidget {
  const _DailyProgressHeatmap({
    required this.values,
    required this.accent,
    required this.secondary,
    required this.tertiary,
  });

  final List<double> values;
  final Color accent;
  final Color secondary;
  final Color tertiary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1726),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFF17243B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: values.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: _heatColor(values[index], accent, secondary, tertiary),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _LegendDot(color: accent, label: 'Strong'),
              const SizedBox(width: 18),
              _LegendDot(color: secondary, label: 'Consistent'),
              const SizedBox(width: 18),
              _LegendDot(color: const Color(0xFF253247), label: 'Low'),
            ],
          ),
        ],
      ),
    );
  }

  Color _heatColor(double value, Color accent, Color secondary, Color tertiary) {
    if (value >= 0.75) return secondary;
    if (value >= 0.45) return accent;
    if (value > 0.0) return tertiary.withValues(alpha: 0.7);
    return const Color(0xFF1A2435);
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1726),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFF17243B)),
      ),
      child: child,
    );
  }
}

class _WeeklyLineChart extends StatelessWidget {
  const _WeeklyLineChart({
    required this.values,
    required this.accent,
  });

  final List<double> values;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    const labels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 10,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: Color(0xFF17243B), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 2,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      color: index == 2 ? Colors.white : Colors.white38,
                      fontSize: 11,
                      fontWeight: index == 2 ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(color: Color(0xFF17243B)),
            bottom: BorderSide(color: Color(0xFF17243B)),
          ),
        ),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              values.length,
              (index) => FlSpot(index.toDouble(), values[index]),
            ),
            isCurved: true,
            color: accent,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: accent.withValues(alpha: 0.14),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                radius: 4,
                color: accent,
                strokeWidth: 2,
                strokeColor: const Color(0xFF0E1726),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyBarChart extends StatelessWidget {
  const _MonthlyBarChart({
    required this.values,
    required this.accent,
    required this.secondary,
  });

  final List<double> values;
  final Color accent;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    const labels = ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'];

    return BarChart(
      BarChartData(
        maxY: 14,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (_) =>
              const FlLine(color: Color(0xFF17243B), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 2,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    labels[index],
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(color: Color(0xFF17243B)),
            bottom: BorderSide(color: Color(0xFF17243B)),
          ),
        ),
        barTouchData: BarTouchData(enabled: false),
        barGroups: List.generate(values.length, (index) {
          final isHighlight = index == 2 || index == 4;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: values[index],
                width: 18,
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: isHighlight
                      ? [secondary, accent]
                      : [accent.withValues(alpha: 0.75), accent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}

class _StatsContent {
  const _StatsContent({
    required this.subtitle,
    required this.primaryLabel,
    required this.completedLabel,
    required this.heatmapTitle,
    required this.progressValue,
    required this.totalValue,
    required this.dateRangeLabel,
    required this.monthLabel,
    required this.heatmapValues,
    required this.weeklyValues,
    required this.monthlyValues,
  });

  final String subtitle;
  final String primaryLabel;
  final String completedLabel;
  final String heatmapTitle;
  final int progressValue;
  final int totalValue;
  final String dateRangeLabel;
  final String monthLabel;
  final List<double> heatmapValues;
  final List<double> weeklyValues;
  final List<double> monthlyValues;
}

class _StatsPalette {
  const _StatsPalette({
    required this.accent,
    required this.secondary,
    required this.tertiary,
  });

  final Color accent;
  final Color secondary;
  final Color tertiary;
}
