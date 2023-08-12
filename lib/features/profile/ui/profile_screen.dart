import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_alert_dialog.dart';
import 'package:play_tennis_hk/components/custom_snack_bar.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/ntrp_level.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';
import 'package:play_tennis_hk/features/profile/ui/districts_list.dart';
import 'package:play_tennis_hk/features/profile/ui/ntrp_level_dropdown_selection.dart';

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
    final isRegistration = ref.read(tokenProvider) == null;
    final userProfile = ref.read(userProfileProvider);

    if (userProfile != null && !isRegistration) {
      usernameController.text = userProfile.username;
      emailController.text = userProfile.email ?? "";
      ageController.text = userProfile.age?.toString() ?? "";
      descriptionController.text = userProfile.description ?? "";
      telegramController.text = userProfile.telegram ?? "";
      signalController.text = userProfile.signal ?? "";
      whatsappController.text = userProfile.whatsapp ?? "";
      isProfilePublic = userProfile.isProfilePublic ?? false;
      ntrpLevelValue = userProfile.ntrpLevel;
      selectedDistricts = userProfile.districts ?? [];
    }
  }

  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = TextEditingController();
  var descriptionController = TextEditingController();
  var telegramController = TextEditingController();
  var whatsappController = TextEditingController();
  var signalController = TextEditingController();

  bool isProfilePublic = true;

  List<District> selectedDistricts = [];

  num ntrpLevelValue = ntrpLevel.first;

  Future<void> onPrimaryButtonPress(BuildContext context) async {
    final isRegistration = ref.read(tokenProvider) == null;

    if (isRegistration) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      try {
        if (_validateForm(context)) {
          await ref.read(userProfileProvider.notifier).register(
                UserProfile(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  ntrpLevel: ntrpLevelValue,
                  age: int.tryParse(ageController.text),
                  description: descriptionController.text,
                  districts: selectedDistricts,
                  telegram: telegramController.text,
                  signal: signalController.text,
                  whatsapp: whatsappController.text,
                  isProfilePublic: isProfilePublic,
                ),
              );
        }
      } catch (e) {
        if (context.mounted) {
          ErrorResolver().resolveError(e, context);
        }
      }
    } else {
      ref.read(userProfileProvider.notifier).logout();
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
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

  bool _validateForm(BuildContext context) {
    final isTextFormFieldValid = _formKey.currentState?.validate();
    final atLeastOneDistrict = selectedDistricts.isNotEmpty;
    final isRegistration = ref.read(tokenProvider) == null;
    final contactMethods = [
      telegramController.text,
      signalController.text,
      whatsappController.text
    ];

    // Username not validated
    if (!RegExp(r'^[a-zA-Z0-9_]{4,12}$').hasMatch(usernameController.text)) {
      _showSnackBar(
        AppLocalizations.of(context)?.usernameValidationError,
        context,
      );
      return false;
    }

    // Email not validated
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailController.text)) {
      _showSnackBar(
        AppLocalizations.of(context)?.emailValidationError,
        context,
      );
      return false;
    }

    // Password not validated
    if (isRegistration &&
        !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,16}$')
            .hasMatch(passwordController.text)) {
      _showSnackBar(
        AppLocalizations.of(context)?.passwordValidationError,
        context,
      );
      return false;
    }

    // Confirm password not validated
    if (confirmPasswordController.text != passwordController.text) {
      _showSnackBar(
        AppLocalizations.of(context)?.confirmPasswordValidationError,
        context,
      );
      return false;
    }

    // Age is not valid
    if (isProfilePublic && !_isValidAge(ageController.text)) {
      _showSnackBar(AppLocalizations.of(context)?.ageValidationError, context);
      return false;
    }

    // At least one district is selected
    if (!atLeastOneDistrict) {
      _showSnackBar(AppLocalizations.of(context)?.atLeastOneDistrict, context);
      return false;
    }

    // At least one contact method is provided
    if (contactMethods.every((element) => element.isEmpty)) {
      _showSnackBar(
        AppLocalizations.of(context)?.atLeastOneContactMethod,
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

  void onSaveSelectDistrict(List<District> newSelectedDistricts) {
    selectedDistricts = newSelectedDistricts;
  }

  bool _isValidAge(String? ageInput) {
    if (ageInput == null || ageInput == "") {
      return true;
    }

    int? age = int.tryParse(ageInput);

    if (age == null) {
      return false;
    }

    return age >= 10 && age <= 100;
  }

  @override
  Widget build(BuildContext context) {
    final isRegistration = ref.watch(tokenProvider) == null;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          _getAppBarTitle(),
          textType: CustomTextType.subtitle,
        ),
        actions: [
          if (!isRegistration) ...[
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () async {
                  try {
                    if (_validateForm(context)) {
                      await ref.read(userProfileProvider.notifier).editProfile(
                            UserProfile(
                              username: usernameController.text,
                              email: emailController.text,
                              ntrpLevel: ntrpLevelValue,
                              age: int.tryParse(ageController.text),
                              description: descriptionController.text,
                              districts: selectedDistricts,
                              telegram: telegramController.text,
                              signal: signalController.text,
                              whatsapp: whatsappController.text,
                              isProfilePublic: isProfilePublic,
                            ),
                          );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ErrorResolver().resolveError(e, context);
                    }
                  }
                },
                child: CustomText(
                  AppLocalizations.of(context)?.save,
                ))
          ]
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomTextFormField(
                    enabled: isRegistration,
                    controller: usernameController,
                    textInputType: TextInputType.name,
                    labelText: "${AppLocalizations.of(context)?.username}",
                    validator: (String? value) {
                      if (!isRegistration) return null;
                      if (value == "" || value == null) {
                        return AppLocalizations.of(context)
                            ?.usernameValidationError;
                      }

                      final RegExp usernameRegex = RegExp(
                        r'^[a-zA-Z0-9_]{4,12}$',
                      );

                      if (usernameRegex.hasMatch(value)) {
                        return null;
                      } else {
                        return AppLocalizations.of(context)
                            ?.usernameValidationError;
                      }
                    },
                  ),
                  CustomTextFormField(
                    enabled: isRegistration,
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: "${AppLocalizations.of(context)?.email}",
                    validator: (value) {
                      if (!isRegistration) return null;
                      if (value == "" || value == null) {
                        return AppLocalizations.of(context)?.email;
                      }
                      final RegExp emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (emailRegex.hasMatch(value)) {
                        return null;
                      } else {
                        return AppLocalizations.of(context)
                            ?.emailValidationError;
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
                        if (!isRegistration) return null;
                        if (value == "" || value == null) {
                          return AppLocalizations.of(context)
                              ?.passwordValidationError;
                        }

                        final RegExp passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,16}$',
                        );

                        if (passwordRegex.hasMatch(value)) {
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
                      controller: confirmPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      labelText:
                          "${AppLocalizations.of(context)?.confirmPassword}",
                      validator: (value) {
                        if (!isRegistration) return null;
                        if (value == "" || value == null) {
                          return AppLocalizations.of(context)?.confirmPassword;
                        }

                        if (value == passwordController.text) {
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
                    child: DistrictsList(
                      selectedDistricts: selectedDistricts,
                      onSaveSelect: onSaveSelectDistrict,
                      maxSelection: 5,
                    ),
                  ),
                  NtrpLevelDropdownSelection(
                    initialValue: ntrpLevelValue,
                    onValueChanged: (value) {
                      ntrpLevelValue = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            AppLocalizations.of(context)?.isProfilePublic,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: isProfilePublic,
                          activeColor: Colors.red,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              isProfilePublic = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomTextFormField(
                        controller: ageController,
                        textInputType: TextInputType.number,
                        labelText:
                            "${AppLocalizations.of(context)?.age}${AppLocalizations.of(context)?.optional}",
                        validator: (value) {
                          if (value == "" || value == null) return null;
                          num age = 0;

                          try {
                            age = int.parse(value);
                          } catch (err) {
                            return AppLocalizations.of(context)
                                ?.ageValidationError;
                          }

                          if (age > 0 || age < 100) {
                            return null;
                          } else {
                            return AppLocalizations.of(context)
                                ?.ageValidationError;
                          }
                        },
                      ),
                      CustomTextFormField(
                        controller: descriptionController,
                        textInputType: TextInputType.text,
                        labelText:
                            "${AppLocalizations.of(context)?.personalDescription}${AppLocalizations.of(context)?.optional}",
                        hintText: AppLocalizations.of(context)
                            ?.personalDescriptionHint,
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
                            return AppLocalizations.of(context)
                                ?.telegramValidationError;
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
                            return AppLocalizations.of(context)
                                ?.telegramValidationError;
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
                            return AppLocalizations.of(context)
                                ?.telegramValidationError;
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isRegistration) {
                                if (_validateForm(context)) {
                                  onPrimaryButtonPress(context);
                                }
                              } else {
                                if (_validateForm(context)) {
                                  onPrimaryButtonPress(context);
                                }
                              }
                            },
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 150),
                              ),
                            ),
                            child: CustomText(_getPrimaryButtonTitle()),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isRegistration,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40, top: 10),
                            child: GestureDetector(
                              child: CustomText(
                                AppLocalizations.of(context)?.deleteAccount,
                                textType: CustomTextType.footnote,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialog(
                                      title: AppLocalizations.of(context)
                                          ?.deleteAccount,
                                      content: AppLocalizations.of(context)
                                          ?.deleteAccountConfirmation,
                                      isCancellable: true,
                                      onConfirm: () async {
                                        try {
                                          await ref
                                              .read(
                                                  userProfileProvider.notifier)
                                              .deleteAccount();
                                          if (context.mounted) {
                                            Navigator.of(context).popUntil(
                                              (route) => route.isFirst,
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ErrorResolver()
                                                .resolveError(e, context);
                                          }
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
