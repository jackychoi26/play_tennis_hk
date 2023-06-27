import 'package:flutter/material.dart';

class PartnerInfoCell extends StatelessWidget {
  const PartnerInfoCell({
    super.key,
    required this.dateTimeLocation,
  });

  final String dateTimeLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dateTimeLocation),
        const Text("Level 3.5 - 4, Double"),
        const Text("jiojasd"),
      ],
    );
  }
}
