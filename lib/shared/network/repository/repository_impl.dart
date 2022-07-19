import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_respnse_model.dart';
import 'package:ibtikar_task/shared/network/api_endpoints.dart';
import 'package:ibtikar_task/shared/network/dio/dio_helper.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';

class RepoImpl extends Repository {
  final DioHelper dioHelper;

  RepoImpl({
    required this.dioHelper,
  });

  @override
  Future<Either<String, PopularPeopleResponseModel>> getPopularPeople({
    int? page,
  }) {
    return _responseHandling<PopularPeopleResponseModel>(
      onSuccess: () async {
        final f = await dioHelper.get(
          EndPoints.popularPerson,
        );
        return PopularPeopleResponseModel.fromJson(f.data);
      },
    );
  }
}

extension on Repository {
  String onServerErrorBase(dynamic e) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.response:
          Object? msg;
          if (e.response?.data is Map) {
            msg = e.response?.data['error_msg'];
            msg ??= e.response?.data['message'];
          } else {
            msg = e.response?.data;
          }
          return msg ?? e.error;
        case DioErrorType.other:
          return e.error;
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
      return const Left(
        'Internet connection problem, please check your connection',
      );
    } catch (e) {
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      final f = onServerErrorBase(e);
      return Left(f);
    }
  }
}
