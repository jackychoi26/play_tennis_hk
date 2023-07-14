import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:play_tennis_hk/components/custom_snack_bar.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/components/show_date_time_picker.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/match_type.dart';
import 'package:play_tennis_hk/features/profile/ui/districts_list.dart';
import 'package:play_tennis_hk/features/profile/ui/usta_level_dropdown_selection.dart';

class CreateTennisMatchScreen extends ConsumerStatefulWidget {
  const CreateTennisMatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTennisMatchScreenState();
}

class CreateTennisMatchScreenState
    extends ConsumerState<CreateTennisMatchScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  var locationController = TextEditingController();
  var remarksController = TextEditingController();

  DateTime? startDateTime;

  DateTime? endDateTime;

  MatchType dropdownValue = MatchType.singles;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  List<District> selectedDistricts = [];

  void onSaveSelectDistrict(List<District> newSelectedDistricts) {
    selectedDistricts = newSelectedDistricts;
  }

  String? _getDateTimeText(DateTime? dateTime) {
    if (dateTime == null) {
      return AppLocalizations.of(context)?.dateValidationError;
    }
    return dateFormat.format(dateTime);
  }

  bool _validateForm(BuildContext context) {
    final isTextFormFieldValid = _formKey.currentState?.validate();
    final atLeastOneDistrict = selectedDistricts.isNotEmpty;

    // Start date and end date are selected
    if (startDateTime == null || endDateTime == null) {
      _showSnackBar(AppLocalizations.of(context)?.dateValidationError, context);
      return false;
    }

    // At least one district is selected
    if (!atLeastOneDistrict) {
      _showSnackBar(AppLocalizations.of(context)?.atLeastOneDistrict, context);
      return false;
    }

    // Location not validated
    if (locationController.text.isEmpty ||
        locationController.text.length > 30) {
      _showSnackBar(
        AppLocalizations.of(context)?.locationValidationError,
        context,
      );
      return false;
    }

    return (isTextFormFieldValid == true && atLeastOneDistrict);
  }

  _showSnackBar(String? message, BuildContext context) {
    CustomSnackBar(
      message: message,
      type: SnackBarType.error,
    ).display(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.createMatch,
          textType: CustomTextType.subtitle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: GestureDetector(
                onTap: () async {
                  final DateTime? selectedDate =
                      await sheetDateTimePicker(context: context);
                  if (selectedDate == null) return;

                  setState(() {
                    startDateTime = selectedDate;
                  });
                },
                child: Row(
                  children: [
                    CustomText(
                        AppLocalizations.of(context)?.startDateTime ?? ""),
                    CustomText(_getDateTimeText(startDateTime))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () async {
                  final DateTime? selectedDate =
                      await sheetDateTimePicker(context: context);
                  if (selectedDate == null) return;

                  setState(() {
                    endDateTime = selectedDate;
                  });
                },
                child: Row(
                  children: [
                    CustomText(AppLocalizations.of(context)?.endDateTime ?? ""),
                    CustomText(_getDateTimeText(endDateTime)),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: DropdownButton<MatchType>(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (MatchType? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: MatchType.values
                      .map<DropdownMenuItem<MatchType>>((MatchType value) {
                    return DropdownMenuItem<MatchType>(
                      value: value,
                      child: Text(value.toLocalizedName(context) ?? ""),
                    );
                  }).toList()),
            ),
            const USTALevelDropdownSelection(),
            Container(
              margin: const EdgeInsets.all(20),
              child: DistrictsList(
                onSaveSelect: onSaveSelectDistrict,
              ),
            ),
            CustomTextFormField(
                controller: locationController,
                textInputType: TextInputType.visiblePassword,
                labelText: AppLocalizations.of(context)?.location,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        ?.locationValidationError;
                  }
                  return null;
                }),
            CustomTextFormField(
              controller: remarksController,
              textInputType: TextInputType.visiblePassword,
              labelText: AppLocalizations.of(context)?.remarks,
              maxLines: 3,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (_validateForm(context)) {
                    print("submit");
                  } else {
                    print("not valid");
                  }
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                child: CustomText(AppLocalizations.of(context)?.submit ?? ""),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
