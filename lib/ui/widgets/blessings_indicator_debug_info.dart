import 'package:flutter/material.dart';
import 'package:leyana/services/blessings_indicator_service.dart';

class BlessingsIndicatorDebugInfo extends StatelessWidget {
  const BlessingsIndicatorDebugInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getDebugInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!;
        final bool shouldShow = data['shouldShow'] as bool;
        final int daysRemaining = data['daysRemaining'] as int;

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'معلومات مؤشر البركات (Debug)',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
              ),
              const SizedBox(height: 4),
              Text('يظهر المؤشر: ${shouldShow ? "نعم" : "لا"}'),
              Text('الأيام المتبقية: $daysRemaining'),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _getDebugInfo() async {
    final bool shouldShow = await BlessingsIndicatorService.shouldShowIndicator();
    final int daysRemaining = await BlessingsIndicatorService.getDaysRemaining();

    return {
      'shouldShow': shouldShow,
      'daysRemaining': daysRemaining,
    };
  }
}
