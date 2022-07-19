import 'package:flutter/widgets.dart';


@immutable
abstract class PopularPeopleStates {
  const PopularPeopleStates();
}

class InitialPopularPeopleState extends PopularPeopleStates {}

class LoadingPopularPeopleState extends PopularPeopleStates {}

class LoadingMorePopularPeopleState extends PopularPeopleStates {}

class ReloadingPopularPeopleState extends PopularPeopleStates {}

class SuccessPopularPeopleState extends PopularPeopleStates {}

class UpdateState extends PopularPeopleStates {}

class ErrorPopularPeopleState extends PopularPeopleStates {
  final String error;

  const ErrorPopularPeopleState(this.error);
}
