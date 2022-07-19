import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';

import 'states.dart';

class PopularPeopleDetailsCubit extends Cubit<PopularPeopleDetailsStates> {
  final Repository _repository;

  PopularPeopleDetailsCubit(this._repository) : super(InitialPopularPeopleDetailsState());

  static PopularPeopleDetailsCubit get(BuildContext context) => BlocProvider.of(context);
}