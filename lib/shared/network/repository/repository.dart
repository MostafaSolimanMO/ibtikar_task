import 'package:dartz/dartz.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_respnse_model.dart';

abstract class Repository {
  Future<Either<String, PopularPeopleResponseModel>> getPopularPeople({
    int? page,
  });
}
