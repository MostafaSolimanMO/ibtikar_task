import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';

import 'states.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleStates> {
  final Repository _repository;

  PopularPeopleCubit(this._repository) : super(InitialPopularPeopleState());

  static PopularPeopleCubit get(BuildContext context) => BlocProvider.of(context);
}