import 'package:flutter/material.dart';

class PartnerInfoCell extends StatelessWidget {
  const PartnerInfoCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.green,
      child: Row(
        children: [
          Image.network("https://picsum.photos/80"),
          const SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "30/6 Friday, 7-9pm, Tai Po Ata dsa  sad a das",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Level 3.5 - 4, Double",
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Please contact me if you want to",
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
