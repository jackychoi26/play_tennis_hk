import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

class PartnerInfoCell extends StatelessWidget {
  const PartnerInfoCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("30/6 Friday, 7-9pm"),
          CustomText("Tai Po"),
          CustomText("Level 3.5 - 4, Double"),
          CustomText("Please contact me if you want to play together"),
        ],
      ),
    );
  }
}
