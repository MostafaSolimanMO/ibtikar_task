import 'package:flutter/widgets.dart';


@immutable
abstract class PeopleDetailsStates {
  const PeopleDetailsStates();
}

class InitialPeopleDetailsState extends PeopleDetailsStates {}

class LoadingPeopleDetailsState extends PeopleDetailsStates {}

class ReloadingPeopleDetailsState extends PeopleDetailsStates {}

class SuccessPeopleDetailsState extends PeopleDetailsStates {}

class UpdateState extends PeopleDetailsStates {}

class ErrorPeopleDetailsState extends PeopleDetailsStates {
  final String error;

  ErrorPeopleDetailsState(this.error);
}