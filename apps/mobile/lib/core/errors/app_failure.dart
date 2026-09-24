import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

enum FailureKind {
  network,
  timeout,
  authentication,
  authorization,
  validation,
  conflict,
  server,
  database,
  unknown,
}

class AppFailure implements Exception {
  AppFailure(this.kind, {String? correlationId})
    : correlationId = correlationId ?? const Uuid().v4();
  final FailureKind kind;
  final String correlationId;
  String get message => switch (kind) {
    FailureKind.network =>
      'You appear to be offline. Check your connection and retry.',
    FailureKind.timeout => 'The request took too long. Please retry.',
    FailureKind.authentication => 'Your session or sign-in code is invalid or expired. Please sign in again.',
    FailureKind.authorization =>
      'Your account does not have permission for this action.',
    FailureKind.validation =>
      'Check the information you entered and try again.',
    FailureKind.conflict => 'This information changed. Refresh and try again.',
    FailureKind.server =>
      'The service is unavailable. Please try again shortly.',
    FailureKind.database => 'We could not load your information. Please retry.',
    FailureKind.unknown => 'Something went wrong. Reference: $correlationId',
  };
  bool get permitsCache =>
      kind == FailureKind.network || kind == FailureKind.timeout;
  @override
  String toString() => 'AppFailure(${kind.name}, $correlationId)';
}

AppFailure mapFailure(Object error) {
  if (error is AppFailure) return error;
  if (error is SocketException) return AppFailure(FailureKind.network);
  if (error is TimeoutException) return AppFailure(FailureKind.timeout);
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionError) {
      return AppFailure(FailureKind.network);
    }
    if ([
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
    ].contains(error.type)) {
      return AppFailure(FailureKind.timeout);
    }
    return AppFailure(FailureKind.server);
  }
  if (error is AuthException) {
    if (error.statusCode == '429') return AppFailure(FailureKind.validation);
    return AppFailure(FailureKind.authentication);
  }
  if (error is PostgrestException) {
    return AppFailure(switch (error.code) {
      '42501' => FailureKind.authorization,
      'PGRST301' || 'PGRST303' => FailureKind.authentication,
      '23505' => FailureKind.conflict,
      '23514' || '22023' || '22P02' => FailureKind.validation,
      _ => FailureKind.database,
    });
  }
  if (error is FormatException || error is TypeError) {
    return AppFailure(FailureKind.server);
  }
  return AppFailure(FailureKind.unknown);
}
