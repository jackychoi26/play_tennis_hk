import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_localized_server_message.dart';

class ErrorResolver {
  void resolveError(Object error, BuildContext context) {
    String errorMessage;

    try {
      if (error is DioException && error.response?.statusCode != 401) {
        errorMessage = error.response?.data['message'];
      } else {
        errorMessage = error.toString();
      }
    } catch (err) {
      errorMessage = 'Something went wrong';
    }

    final localizedMessage = errorMessage.toLocalizedServerMessage(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizedMessage ?? 'An error occurred'),
      ),
    );
  }

  bool notTimeoutException(err) {
    return err.type != DioExceptionType.sendTimeout ||
        err.type != DioExceptionType.receiveTimeout;
  }
}
