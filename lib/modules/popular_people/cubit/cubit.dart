import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_item_model.dart';
import 'package:ibtikar_task/modules/popular_people/model/popular_people_respnse_model.dart';
import 'package:ibtikar_task/shared/extensions/cubit_extension.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';

import 'states.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleStates> {
  final Repository _repository;

  PopularPeopleCubit(this._repository) : super(InitialPopularPeopleState());

  static PopularPeopleCubit get(BuildContext context) =>
      BlocProvider.of(context);

  PopularPeopleResponseModel? popularPeopleResponse;
  List<PopularPeopleItemModel> popularPeopleFeed = <PopularPeopleItemModel>[];
  int page = 1;

  Future<void> getPopularPeople() async {
    if (page != 1) {
      safeEmit(LoadingMorePopularPeopleState());
    } else {
      safeEmit(LoadingPopularPeopleState());
    }

    final f = await _repository.getPopularPeople(
      page: page,
    );
    f.fold(
      (l) {
        safeEmit(ErrorPopularPeopleState(l));
      },
      (r) {
        popularPeopleResponse = r;
        popularPeopleFeed.addAll(popularPeopleResponse!.results!);

        page++;
        safeEmit(SuccessPopularPeopleState());
      },
    );
  }

  Future<void> refresh() async {
    page = 1;
    popularPeopleFeed.clear();
    getPopularPeople();
  }
}
