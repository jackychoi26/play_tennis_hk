import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_snack_bar.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';

class DistrictsSelectionScreen extends StatefulWidget {
  const DistrictsSelectionScreen({
    required this.districts,
    required this.onSaveSelect,
    required this.selectedDistricts,
    super.key,
  });

  final List<District> districts;
  final void Function(List<District>) onSaveSelect;

  final List<District> selectedDistricts;

  @override
  State<StatefulWidget> createState() => DistrictsSelectionScreenState();
}

class DistrictsSelectionScreenState extends State<DistrictsSelectionScreen> {
  List<District> districts = [];
  void Function(List<District>) onSaveSelect = (districts) {};

  List<District> selectedDistricts = [];

  @override
  void initState() {
    super.initState();
    districts = widget.districts;
    onSaveSelect = widget.onSaveSelect;
    selectedDistricts = widget.selectedDistricts;
  }

  bool _isSelected(District district) {
    return selectedDistricts.contains(district);
  }

  @override
  Widget build(BuildContext context) {
    final localeName = AppLocalizations.of(context)?.localeName;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.chooseDistricts,
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
                  if (selectedDistricts.length > 5) {
                    CustomSnackBar(
                      message: AppLocalizations.of(context)?.tooManyDistricts,
                      type: SnackBarType.error,
                    ).display(context);
                  } else {
                    onSaveSelect(selectedDistricts);
                    Navigator.pop(context);
                  }
                },
                child: CustomText(
                  AppLocalizations.of(context)?.save,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var district in districts) ...[
            CheckboxListTile(
              title: CustomText(district.toLocalizedName(localeName)),
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
          ],
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
