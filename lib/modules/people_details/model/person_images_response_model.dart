import 'package:ibtikar_task/modules/people_details/model/person_image_model.dart';

class PersonImagesResponseModel {
  int? id;
  List<PersonImageModel>? images;

  PersonImagesResponseModel({
    this.id,
    this.images,
  });

  PersonImagesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['profiles'] != null) {
      images = <PersonImageModel>[];
      json['profiles'].forEach((v) {
        images!.add(PersonImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (images != null) {
      data['profiles'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
