import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/partner_info_cell.dart';

class PartnerList extends StatefulWidget {
  const PartnerList({super.key});

  @override
  State<StatefulWidget> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const [
        PartnerInfoCell(),
        PartnerInfoCell(),
        PartnerInfoCell(),
      ],
    );
  }
}
