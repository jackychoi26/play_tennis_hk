import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/components/username_text_field.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/ui/districts_list.dart';
import 'package:play_tennis_hk/features/profile/ui/usta_level_dropdown_selection.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordAgainController = TextEditingController();
  var ageController = TextEditingController();
  var descriptionController = TextEditingController();
  var telegramController = TextEditingController();
  var whatsappController = TextEditingController();
  var signalController = TextEditingController();

  void onPrimaryButtonPress(BuildContext context) {
    final isRegistration = ref.read(tokenProvider) == null;

    if (isRegistration) {
      ref.read(tokenProvider.notifier).setAccessToken("Hello");
    } else {
      ref.read(tokenProvider.notifier).removeAccessToken();
    }

    Navigator.pop(context);
  }

  String? _getAppBarTitle() {
    final isRegistration = ref.watch(tokenProvider) == null;

    if (isRegistration) {
      return AppLocalizations.of(context)?.register;
    } else {
      return AppLocalizations.of(context)?.editProfile;
    }
  }

  String? _getPrimaryButtonTitle() {
    final isRegistration = ref.read(tokenProvider) == null;

    if (isRegistration) {
      return AppLocalizations.of(context)?.register;
    } else {
      return AppLocalizations.of(context)?.logout;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRegistration = ref.watch(tokenProvider) == null;

    var usernameTextField = UsernameTextField(controller: usernameController);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(_getAppBarTitle()),
        actions: [
          if (!isRegistration) ...[
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {},
                child: CustomText(
                  AppLocalizations.of(context)?.save,
                ))
          ]
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            usernameTextField,
            CustomTextFormField(
              enabled: isRegistration,
              controller: usernameController,
              textInputType: TextInputType.name,
              labelText: "${AppLocalizations.of(context)?.username}",
              validator: (value) {
                final username = value as String;

                final RegExp usernameRegex = RegExp(
                  r'^[a-zA-Z0-9_]{4,12}$',
                );

                if (usernameRegex.hasMatch(username)) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.usernameValidationError;
                }
              },
            ),
            CustomTextFormField(
              enabled: isRegistration,
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              labelText: "${AppLocalizations.of(context)?.email}",
              validator: (value) {
                final email = value as String;

                final RegExp emailRegex = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );

                if (emailRegex.hasMatch(email)) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.emailValidationError;
                }
              },
            ),
            Visibility(
              visible: isRegistration,
              child: CustomTextFormField(
                isPassword: true,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                labelText: "${AppLocalizations.of(context)?.password}",
                validator: (value) {
                  final password = value as String;

                  final RegExp passwordRegex = RegExp(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,16}$',
                  );

                  if (passwordRegex.hasMatch(password)) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)
                        ?.passwordValidationError;
                  }
                },
              ),
            ),
            Visibility(
              visible: isRegistration,
              child: CustomTextFormField(
                isPassword: true,
                controller: passwordAgainController,
                textInputType: TextInputType.visiblePassword,
                labelText: "${AppLocalizations.of(context)?.confirmPassword}",
                validator: (value) {
                  final confirmPassword = value as String;

                  if (confirmPassword == passwordController.text) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)
                        ?.confirmPasswordValidationError;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: const DistrictsList(),
            ),
            CustomTextFormField(
              controller: ageController,
              textInputType: TextInputType.number,
              labelText:
                  "${AppLocalizations.of(context)?.age}${AppLocalizations.of(context)?.optional}",
              validator: (value) {
                if (value == "") return null;
                num age = 0;

                try {
                  age = int.parse(value);
                } catch (err) {
                  return AppLocalizations.of(context)?.ageValidationError;
                }

                if (age > 0 || age < 100) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.ageValidationError;
                }
              },
            ),
            CustomTextFormField(
              controller: descriptionController,
              textInputType: TextInputType.text,
              labelText: AppLocalizations.of(context)?.personalDescription,
              hintText: AppLocalizations.of(context)?.personalDescriptionHint,
              maxLines: 3,
              validator: (value) {
                final personalDescription = value as String;

                if (personalDescription.length < 100) {
                  return null;
                } else {
                  return AppLocalizations.of(context)
                      ?.personalDescriptionValidationError;
                }
              },
            ),
            const USTALevelDropdownSelection(),
            CustomTextFormField(
              controller: telegramController,
              textInputType: TextInputType.text,
              labelText:
                  "${AppLocalizations.of(context)?.telegram}${AppLocalizations.of(context)?.optional}",
              hintText: AppLocalizations.of(context)?.leaveContact,
              validator: (value) {
                final telegram = value as String;

                if (telegram.length < 20) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.telegramValidationError;
                }
              },
            ),
            CustomTextFormField(
              controller: whatsappController,
              textInputType: TextInputType.text,
              labelText:
                  "${AppLocalizations.of(context)?.whatsapp}${AppLocalizations.of(context)?.optional}",
              hintText: AppLocalizations.of(context)?.leaveContact,
              validator: (value) {
                final whatsapp = value as String;

                if (whatsapp.length < 20) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.telegramValidationError;
                }
              },
            ),
            CustomTextFormField(
              controller: signalController,
              textInputType: TextInputType.text,
              labelText:
                  "${AppLocalizations.of(context)?.signal}${AppLocalizations.of(context)?.optional}",
              hintText: AppLocalizations.of(context)?.leaveContact,
              validator: (value) {
                final signal = value as String;

                if (signal.length < 20) {
                  return null;
                } else {
                  return AppLocalizations.of(context)?.telegramValidationError;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: clean up the mess
                  if (isRegistration) {
                    if (_formKey.currentState?.validate() == true) {
                      onPrimaryButtonPress(context);
                    }
                  } else {
                    onPrimaryButtonPress(context);
                  }
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                  ),
                ),
                child: CustomText(_getPrimaryButtonTitle()),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
