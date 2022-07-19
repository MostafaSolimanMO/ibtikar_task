import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/shared/network/api_endpoints.dart';

import 'states.dart';

class NetworkCubit extends Cubit<NetworkStates> {
  NetworkCubit() : super(InitialNetworkState());

  static NetworkCubit get(BuildContext context) => BlocProvider.of(context);

  Future<Map<String, dynamic>> onRequestQueryPrams() async {
    return {
      "api_key": EndPoints.token,
    };
  }

  Future<void> onResponseCallback(Response response) async {}

  Future<void> onErrorCallback(DioError error) async {
    if (error.response != null) {
      final response = error.response!;
      debugPrint('onErrorCallback: ${response.data}');
    }
  }
}
