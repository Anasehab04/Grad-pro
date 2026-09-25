import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'plan_trip_step4_screen.dart';

class PlanTripStep3Screen extends StatefulWidget {
  final String destination;
  final DateTimeRange dateRange;

  const PlanTripStep3Screen({
    super.key,
    required this.destination,
    required this.dateRange,
  });

  @override
  State<PlanTripStep3Screen> createState() => _PlanTripStep3ScreenState();
}

class _PlanTripStep3ScreenState extends State<PlanTripStep3Screen> {
  String? selectedStyle;

  final List<Map<String, String>> styles = [
    {'emoji': '💰', 'title': 'Economy', 'subtitle': 'Budget-friendly, local experiences'},
    {'emoji': '✈️', 'title': 'Comfort', 'subtitle': 'Balanced mix of quality & value'},
    {'emoji': '👑', 'title': 'Luxury', 'subtitle': 'Premium hotels, private tours'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text('Plan Your Trip'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('3/4', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16)),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Row(
            children: List.generate(4, (i) => Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i <= 2 ? AppColors.cyan : AppColors.cyan.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'BUDGET',
              style: TextStyle(color: AppColors.yellow, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            const Text(
              "What's your travel style?",
              style: TextStyle(color: AppColors.textWhite, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),

            ...styles.map((s) {
              final isSelected = selectedStyle == s['title'];
              return GestureDetector(
                onTap: () => setState(() => selectedStyle = s['title']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.navyCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.cyan : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(s['emoji']!, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s['title']!,
                            style: TextStyle(
                              color: isSelected ? AppColors.yellow : AppColors.textWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            s['subtitle']!,
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),
            YellowButton(
              label: 'CONTINUE',
              enabled: selectedStyle != null,
              onPressed: selectedStyle != null
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlanTripStep4Screen(
                            destination: widget.destination,
                            dateRange: widget.dateRange,
                            travelStyle: selectedStyle!,
                          ),
                        ),
                      )
                  : null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
