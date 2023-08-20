import 'package:flutter/material.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_enum.dart';
import 'package:play_tennis_hk/domain/server_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ServerMessageTranslator on String {
  String? toLocalizedServerMessage(BuildContext context) {
    if (isEmpty) return AppLocalizations.of(context)?.somethingWentWrong;

    ServerMessage serverMessage;

    try {
      serverMessage = toEnum<ServerMessage>(this, ServerMessage.values);
    } catch (err) {
      return AppLocalizations.of(context)?.somethingWentWrong;
    }

    switch (serverMessage) {
      case ServerMessage.createTennisMatchSuccess:
        return AppLocalizations.of(context)?.createTennisMatchSuccess;
      case ServerMessage.tooManyMatchesCreatedFailure:
        return AppLocalizations.of(context)?.tooManyMatchesCreatedFailure;
      case ServerMessage.missingContactInfoFailure:
        return AppLocalizations.of(context)?.missingContactInfoFailure;
      case ServerMessage.createTennisMatchFailure:
        return AppLocalizations.of(context)?.createTennisMatchFailure;
      case ServerMessage.deleteTennisMatchSuccess:
        return AppLocalizations.of(context)?.deleteTennisMatchSuccess;
      case ServerMessage.deleteTennisMatchFailure:
        return AppLocalizations.of(context)?.deleteTennisMatchFailure;
      case ServerMessage.getTennisMatchesByUserIdSuccess:
        return AppLocalizations.of(context)?.getTennisMatchesByUserIdSuccess;
      case ServerMessage.getTennisMatchesByUserIdFailure:
        return AppLocalizations.of(context)?.getTennisMatchesByUserIdFailure;
      case ServerMessage.getTennisMatchesSuccess:
        return AppLocalizations.of(context)?.getTennisMatchesSuccess;
      case ServerMessage.getTennisMatchesFailure:
        return AppLocalizations.of(context)?.getTennisMatchesFailure;
      case ServerMessage.changePasswordSuccess:
        return AppLocalizations.of(context)?.changePasswordSuccess;
      case ServerMessage.changePasswordFailure:
        return AppLocalizations.of(context)?.changePasswordFailure;
      case ServerMessage.samePasswordFailure:
        return AppLocalizations.of(context)?.samePasswordFailure;
      case ServerMessage.editProfileSuccess:
        return AppLocalizations.of(context)?.editProfileSuccess;
      case ServerMessage.editProfileFailure:
        return AppLocalizations.of(context)?.editProfileFailure;
      case ServerMessage.getProfileSuccess:
        return AppLocalizations.of(context)?.getProfileSuccess;
      case ServerMessage.getProfileFailure:
        return AppLocalizations.of(context)?.getProfileFailure;
      case ServerMessage.getPublicProfilesSuccess:
        return AppLocalizations.of(context)?.getPublicProfilesSuccess;
      case ServerMessage.getPublicProfilesFailure:
        return AppLocalizations.of(context)?.getPublicProfilesFailure;
      case ServerMessage.loginSuccess:
        return AppLocalizations.of(context)?.loginSuccess;
      case ServerMessage.loginFailure:
        return AppLocalizations.of(context)?.loginFailure;
      case ServerMessage.registerSuccess:
        return AppLocalizations.of(context)?.registerSuccess;
      case ServerMessage.usernameAlreadyExistedFailure:
        return AppLocalizations.of(context)?.usernameAlreadyExistedFailure;
      case ServerMessage.emailAlreadyExistedFailure:
        return AppLocalizations.of(context)?.emailAlreadyExistedFailure;
      case ServerMessage.missingParam:
        return AppLocalizations.of(context)?.missingParam;
      case ServerMessage.invalidDistrict:
        return AppLocalizations.of(context)?.invalidDistrict;
      case ServerMessage.invalidDistricts:
        return AppLocalizations.of(context)?.invalidDistricts;
      case ServerMessage.invalidEmailAddress:
        return AppLocalizations.of(context)?.invalidEmailAddress;
      case ServerMessage.invalidIsProfilePublic:
        return AppLocalizations.of(context)?.invalidIsProfilePublic;
      case ServerMessage.invalidMatchType:
        return AppLocalizations.of(context)?.invalidMatchType;
      case ServerMessage.invalidNtrpLevel:
        return AppLocalizations.of(context)?.invalidNtrpLevel;
      case ServerMessage.invalidPassword:
        return AppLocalizations.of(context)?.invalidPassword;
      case ServerMessage.invalidSignal:
        return AppLocalizations.of(context)?.invalidSignal;
      case ServerMessage.invalidTelegram:
        return AppLocalizations.of(context)?.invalidTelegram;
      case ServerMessage.invalidUsername:
        return AppLocalizations.of(context)?.invalidUsername;
      case ServerMessage.invalidWhatsapp:
        return AppLocalizations.of(context)?.invalidWhatsapp;
      case ServerMessage.invalidDescription:
        return AppLocalizations.of(context)?.invalidDescription;
      case ServerMessage.missingNtrpLevel:
        return AppLocalizations.of(context)?.missingNtrpLevel;
      case ServerMessage.missingTennisMatchID:
        return AppLocalizations.of(context)?.missingTennisMatchId;
      case ServerMessage.missingUsername:
        return AppLocalizations.of(context)?.missingUsername;
      case ServerMessage.missingPassword:
        return AppLocalizations.of(context)?.missingPassword;
      case ServerMessage.missingEmail:
        return AppLocalizations.of(context)?.missingEmail;
      case ServerMessage.missingDistricts:
        return AppLocalizations.of(context)?.missingDistricts;
      case ServerMessage.missingIsProfilePublic:
        return AppLocalizations.of(context)?.missingIsProfilePublic;
      case ServerMessage.internalServerError:
        return AppLocalizations.of(context)?.internalServerError;
      case ServerMessage.updateSettingsError:
        return AppLocalizations.of(context)?.updateSettingsFailure;
      default:
        return AppLocalizations.of(context)?.somethingWentWrong;
    }
  }
}
