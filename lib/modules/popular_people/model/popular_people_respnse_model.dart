import 'package:ibtikar_task/modules/popular_people/model/popular_people_item_model.dart';

class PopularPeopleResponseModel {
  int? page;
  List<PopularPeopleItemModel>? results;
  int? totalPages;
  int? totalResults;

  PopularPeopleResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularPeopleResponseModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PopularPeopleItemModel>[];
      json['results'].forEach((v) {
        results!.add(PopularPeopleItemModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
