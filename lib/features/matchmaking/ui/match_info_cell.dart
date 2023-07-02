import 'package:flutter/material.dart';

class MatchInfoCell extends StatelessWidget {
  const MatchInfoCell({
    required this.dateTime,
    required this.location,
    required this.ustaLevelRange,
    this.description,
    super.key,
  });

  final String dateTime;
  final String location;
  final List<double> ustaLevelRange;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dateTime),
          Text(location),
          const Text('3.5-4'),
          Text(description ?? ""),
        ],
      ),
    );
  }
}
