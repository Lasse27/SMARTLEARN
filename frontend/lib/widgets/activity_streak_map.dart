import 'package:flutter/material.dart';

class ActivityStreakMap extends StatelessWidget {
  const ActivityStreakMap({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy-Daten: 15 Wochen mit je 7 Tagen (true = gelernt)
    final weeks = List.generate(
      15,
      (w) => List.generate(7, (d) => (w + d) % 3 != 0),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final week in weeks)
            Column(
              children: [
                for (final active in week)
                  Container(
                    width: 14,
                    height: 14,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: active ? Colors.green : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
