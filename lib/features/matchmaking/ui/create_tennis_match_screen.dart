import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

class CreateTennisMatchScreen extends ConsumerStatefulWidget {
  const CreateTennisMatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTennisMatchScreenState();
}

class CreateTennisMatchScreenState
    extends ConsumerState<CreateTennisMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(AppLocalizations.of(context)?.createMatch),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}
