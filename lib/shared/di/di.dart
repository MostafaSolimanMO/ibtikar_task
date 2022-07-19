import 'package:get_it/get_it.dart';
import 'package:ibtikar_task/modules/popular_people/cubit/cubit.dart';
import 'package:ibtikar_task/shared/network/api_endpoints.dart';
import 'package:ibtikar_task/shared/network/cubit/cubit.dart';
import 'package:ibtikar_task/shared/network/dio/dio_helper.dart';
import 'package:ibtikar_task/shared/network/dio/dio_impl.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';
import 'package:ibtikar_task/shared/network/repository/repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.I;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<NetworkCubit>(
    () => NetworkCubit(),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImpl(
      baseURL: EndPoints.baseUrl,
      onRequestQueryPrams: di<NetworkCubit>().onRequestQueryPrams,
      onResponseCallback: di<NetworkCubit>().onResponseCallback,
      onErrorCallback: di<NetworkCubit>().onErrorCallback,
    ),
  );

  di.registerLazySingleton<Repository>(
    () => RepoImpl(
      dioHelper: di<DioHelper>(),
    ),
  );

  di.registerFactory<PopularPeopleCubit>(
    () => PopularPeopleCubit(
      di<Repository>(),
    ),
  );
}
