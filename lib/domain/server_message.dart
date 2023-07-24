enum ServerMessage {
  createTennisMatchSuccess,
  tooManyMatchesCreatedFailure,
  missingContactInfoFailure,
  createTennisMatchFailure,
  deleteTennisMatchSuccess,
  deleteTennisMatchFailure,
  getTennisMatchesByUserIdSuccess,
  getTennisMatchesByUserIdFailure,
  getTennisMatchesSuccess,
  getTennisMatchesFailure,
  changePasswordSuccess,
  changePasswordFailure,
  samePasswordFailure,
  editProfileSuccess,
  editProfileFailure,
  getProfileSuccess,
  getProfileFailure,
  getPublicProfilesSuccess,
  getPublicProfilesFailure,
  loginSuccess,
  loginFailure,
  registerSuccess,
  usernameAlreadyExistedFailure,
  emailAlreadyExistedFailure,
  missingParam,
  invalidDistrict,
  invalidDistricts,
  invalidEmailAddress,
  invalidIsProfilePublic,
  invalidMatchType,
  invalidNTRPLevel,
  invalidPassword,
  invalidSignal,
  invalidTelegram,
  invalidUsername,
  invalidWhatsapp,
  invalidDescription,
  missingNTRPLevel,
  missingTennisMatchID,
  missingUsername,
  missingPassword,
  missingEmail,
  missingDistricts,
  missingIsProfilePublic,
  internalServerError,
}
