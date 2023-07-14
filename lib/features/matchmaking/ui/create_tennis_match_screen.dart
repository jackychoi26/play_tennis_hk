import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/components/show_date_time_picker.dart';
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

  String? _getDateTimeText(DateTime? dateTime) {
    if (dateTime == null) return dateFormat.format(DateTime.now());
    return dateFormat.format(dateTime);
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: const DistrictsList(),
            ),
            CustomTextFormField(
              controller: locationController,
              textInputType: TextInputType.visiblePassword,
              labelText: AppLocalizations.of(context)?.location,
            ),
            CustomTextFormField(
              controller: remarksController,
              textInputType: TextInputType.visiblePassword,
              labelText: AppLocalizations.of(context)?.remarks,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
