import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/profile/ui/districts_selection_screen.dart';

class DistrictsList extends StatefulWidget {
  const DistrictsList({
    super.key,
    required this.onSaveSelect,
  });

  final void Function(List<District> newSelectedDistricts) onSaveSelect;

  @override
  State<StatefulWidget> createState() {
    return DistrictsListState();
  }
}

class DistrictsListState extends State<DistrictsList> {
  // TODO: performance issue because we are looping it uncessarily many times
  final districts = District.values.toList();

  List<District> selectedDistricts = [];

  void _onSaveSelect(List<District> newSelectedDistricts) {
    setState(() {
      selectedDistricts = newSelectedDistricts;
      widget.onSaveSelect(newSelectedDistricts);
    });
  }

  Color _getCardColor(District district) {
    switch (district.toRegion()) {
      case Region.hkIsland:
        return Colors.blue;
      case Region.kowloon:
        return Colors.red;
      case Region.newTerritories:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DistrictsSelectionScreen(
                  selectedDistricts: selectedDistricts,
                  districts: districts,
                  onSaveSelect: _onSaveSelect,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CustomText("${AppLocalizations.of(context)?.chooseDistricts}  "),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
        Wrap(
          children: [
            for (var district in selectedDistricts) ...[
              Card(
                color: _getCardColor(district),
                margin: const EdgeInsets.only(right: 12, top: 12),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomText(
                    district.toLocalizedName(
                        AppLocalizations.of(context)?.localeName),
                  ),
                ),
              )
            ]
          ],
        )
      ],
    );
  }
}
