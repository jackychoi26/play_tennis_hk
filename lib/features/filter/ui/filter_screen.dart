import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/filter/ui/ntrp_level_range.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/ntrp_level.dart';

class FilteringScreen extends ConsumerStatefulWidget {
  const FilteringScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilteringScreenState();
}

class _FilteringScreenState extends ConsumerState<FilteringScreen> {
  final List<Region> regions = Region.values.toList();
  Map<Region, List<District>> regionsDictionary = {};

  List<District> selectedDistricts = [];

  bool _isSelected(District district) {
    return selectedDistricts.contains(district);
  }

  num _lowerNtrpLevel = 1.0;
  num _upperNtrpLevel = 1.0;

  void _onLowerNtrpLevelChanged(num value) {
    if (ntrpLevel.contains(value)) {
      _lowerNtrpLevel = value;
    }
  }

  void _onUpperNtrpLevelChanged(num value) {
    if (ntrpLevel.contains(value)) {
      _upperNtrpLevel = value;
    }
  }

  @override
  void initState() {
    Region.values.toList().forEach((element) {
      regionsDictionary[element] = [];
    });
    District.values.toList().forEach((element) {
      (regionsDictionary[element.toRegion()] as List<District>).add(element);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.filter,
          textType: CustomTextType.subtitle,
        ),
        actions: [
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  selectedDistricts;
                  [_lowerNtrpLevel, _upperNtrpLevel];
                  Navigator.of(context).pop();
                  // TODO: back to API call
                },
                child: CustomText(
                  AppLocalizations.of(context)?.save,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: regions.length,
        padding: const EdgeInsets.only(bottom: 100, top: 20),
        itemBuilder: (context, index) {
          final region = regions[index];

          return Column(
            children: [
              if (index == 0) ...[
                NtrpLevelRange(
                  lowerNtrpLevel: _lowerNtrpLevel,
                  upperNtrpLevel: _upperNtrpLevel,
                  onLowerNtrpLevelChange: _onLowerNtrpLevelChanged,
                  onUpperNtrpLevelChange: _onUpperNtrpLevelChanged,
                ),
              ],
              ExpansionTile(
                title: CustomText(
                  region.toLocalizedName(context),
                ),
                children: [
                  for (var district
                      in (regionsDictionary[region] as List<District>)) ...[
                    CheckboxListTile(
                      title: CustomText(district.toLocalizedName(context)),
                      value: _isSelected(district),
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            if (value) {
                              selectedDistricts.add(district);
                            } else {
                              selectedDistricts.remove(district);
                            }
                          });
                        }
                      },
                    )
                  ]
                ],
              ),
              if (index == regions.length - 1) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedDistricts = [];
                          _lowerNtrpLevel = 1.0;
                          _upperNtrpLevel = 7.0;
                        });
                      },
                      child: CustomText(AppLocalizations.of(context)?.reset),
                    )
                  ],
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
