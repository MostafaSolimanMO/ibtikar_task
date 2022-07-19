import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/modules/people_details/model/person_image_model.dart';
import 'package:ibtikar_task/modules/people_details/model/person_images_response_model.dart';
import 'package:ibtikar_task/shared/extensions/cubit_extension.dart';
import 'package:ibtikar_task/shared/network/repository/repository.dart';

import 'states.dart';

class PeopleDetailsCubit extends Cubit<PeopleDetailsStates> {
  final Repository _repository;

  PeopleDetailsCubit(this._repository) : super(InitialPeopleDetailsState());

  static PeopleDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  PersonImagesResponseModel? personImagesResponseModel;
  List<PersonImageModel> personImages = <PersonImageModel>[];

  Future<void> getPersonImages({
    required int personId,
  }) async {
    safeEmit(LoadingPeopleDetailsState());

    final f = await _repository.getPersonImages(
      personId: personId,
    );
    f.fold(
      (l) {
        safeEmit(ErrorPeopleDetailsState(l));
      },
      (r) {
        personImagesResponseModel = r;
        personImages.addAll(personImagesResponseModel!.images!);
        safeEmit(SuccessPeopleDetailsState());
      },
    );
  }
}
