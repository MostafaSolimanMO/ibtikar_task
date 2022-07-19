import 'package:flutter/widgets.dart';


@immutable
abstract class PopularPeopleDetailsStates {
  const PopularPeopleDetailsStates();
}

class InitialPopularPeopleDetailsState extends PopularPeopleDetailsStates {}

class LoadingPopularPeopleDetailsState extends PopularPeopleDetailsStates {}

class ReloadingPopularPeopleDetailsState extends PopularPeopleDetailsStates {}

class SuccessPopularPeopleDetailsState extends PopularPeopleDetailsStates {}

class UpdateState extends PopularPeopleDetailsStates {}

class ErrorPopularPeopleDetailsState extends PopularPeopleDetailsStates {
  final String error;

  const ErrorPopularPeopleDetailsState(this.error);
}