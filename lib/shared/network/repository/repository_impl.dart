import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibtikar_task/shared/network/dio/dio_helper.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';


class RepoImpl extends Repository {
  final DioHelper dioHelper;

  RepoImpl({
    required this.dioHelper,
  });
}

extension on Repository {
  String onServerErrorBase(dynamic e) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.response:
          Object? msg;
          msg = e.response?.data['error_msg'];
          msg ??= e.response?.data['message'];
          return msg ?? e.error;
        case DioErrorType.other:
          return e.error.toString();
        default:
          return e.toString();
      }
    }
    return e.toString();
  }

  Future<Either<String, T>> _responseHandling<T>({
    required Future<dynamic> Function() onSuccess,
    Future<String> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess.call();
      return Right(f);
    } on SocketException {
      return const Left('تحقق من إتصالك بالإنترنت ثم أعد المحاولة');
    } catch (e) {
      debugPrint('Error: $e');
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      final f = onServerErrorBase(e);
      return Left(f);
    }
  }
}
