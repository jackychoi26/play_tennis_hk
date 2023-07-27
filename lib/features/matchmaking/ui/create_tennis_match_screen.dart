import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_snack_bar.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/components/show_date_time_picker.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/match_type.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/profile/ui/districts_list.dart';
import 'package:play_tennis_hk/features/profile/ui/ntrp_level_dropdown_selection.dart';

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

  var courtController = TextEditingController();
  var remarksController = TextEditingController();

  DateTime? startDateTime;

  DateTime? endDateTime;

  MatchType dropdownValue = MatchType.singles;

  List<District> selectedDistricts = [];

  num selectedNtrpLevel = 1;

  void onSaveSelectDistrict(List<District> newSelectedDistricts) {
    selectedDistricts = newSelectedDistricts;
  }

  String? _getDateTimeText(String? localeName, DateTime? dateTime) {
    if (dateTime == null) {
      return AppLocalizations.of(context)?.dateTimeEmptyError;
    }

    return "${dateTime.getLocalizedMonthDayValue(localeName)} ${dateTime.getHourIn12HoursFormat()}${dateTime.getAmOrPm()}";
  }

  // Returns true if they are valid
  // For this to be true, the start and end time must be
  // 1. On the same day, because no match will last to the next day
  // 2. End time must be later than start time by at least 1 hour
  bool _validateStartEndDateTime(
    DateTime? startDateTime,
    DateTime? endDateTime,
  ) {
    if (startDateTime == null || endDateTime == null) return false;

    final isSameDay = startDateTime.year == endDateTime.year &&
        startDateTime.month == endDateTime.month &&
        startDateTime.day == endDateTime.day;

    if (!isSameDay) return false;

    Duration minimumDuration = const Duration(hours: 1);
    Duration durationDifference = endDateTime.difference(startDateTime);

    return durationDifference >= minimumDuration;
  }

  bool _validateForm(BuildContext context) {
    final isTextFormFieldValid = _formKey.currentState?.validate();
    final atLeastOneDistrict = selectedDistricts.isNotEmpty;

    // Start and end time are invalid
    if (!_validateStartEndDateTime(startDateTime, endDateTime)) {
      _showSnackBar(
          AppLocalizations.of(context)?.dateTimeValidationError, context);
      return false;
    }

    // At least one district is selected
    if (!atLeastOneDistrict) {
      _showSnackBar(AppLocalizations.of(context)?.atLeastOneDistrict, context);
      return false;
    }

    // Location not validated
    if (courtController.text.isEmpty || courtController.text.length > 30) {
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
    final localeName = AppLocalizations.of(context)?.localeName;

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
                        "${AppLocalizations.of(context)?.startDateTime}: "),
                    CustomText(_getDateTimeText(localeName, startDateTime))
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
                    CustomText(
                        "${AppLocalizations.of(context)?.endDateTime}: "),
                    CustomText(_getDateTimeText(localeName, endDateTime)),
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
                      child: CustomText(value.toLocalizedName(context)),
                    );
                  }).toList()),
            ),
            NTRPLevelDropdownSelection(
              onValueChanged: (num value) {
                selectedNtrpLevel = value;
              },
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: DistrictsList(
                onSaveSelect: onSaveSelectDistrict,
                maxSelection: 1,
              ),
            ),
            CustomTextFormField(
                controller: courtController,
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
                onPressed: () async {
                  try {
                    if (_validateForm(context)) {
                      await ref.read(matchesProvider.notifier).createMatch(
                            TennisMatch(
                              startDateTime: startDateTime!,
                              endDateTime: endDateTime!,
                              matchType: dropdownValue,
                              ntrpLevel: selectedNtrpLevel,
                              court: courtController.text,
                              remarks: remarksController.text,
                              district: selectedDistricts.first,
                            ),
                          );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ErrorResolver().resolveError(e, context);
                    }
                  }
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                child: CustomText(AppLocalizations.of(context)?.submit),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
