import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_info_cell.dart';
import 'dart:async';

class PartnerListScreen extends ConsumerStatefulWidget {
  const PartnerListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PartnerListScreenState();
}

class PartnerListScreenState extends ConsumerState<PartnerListScreen> {
  List data = [
    "Flutter Tutorial 1",
    "Flutter Tutorial 2",
    "Flutter Tutorial 3",
    "Flutter Tutorial 4",
    "Flutter Tutorial 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Refresh Indicator"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            updateData();
          },
          child: ListView(
            children: List.generate(
              data.length,
              (index) => Card(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(data[index]),
                ),
              ),
            ),
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            itemExtent: 50,
          ),
          color: Colors.white,
          backgroundColor: Colors.purple,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
        ));
  }

  void updateData() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      int i = data.length + 1;
      data.add("Flutter Tutorial $i");
      timer.cancel();
      setState(() {});
    });
  }
}

// class _PartnerListState extends State<PartnerList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: const [
//         PartnerInfoCell(),
//         PartnerInfoCell(),
//         PartnerInfoCell(),
//       ],
      
//     );
//   }
// }
