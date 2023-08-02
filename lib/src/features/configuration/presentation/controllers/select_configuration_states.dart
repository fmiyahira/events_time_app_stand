// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class SelectConfigurationState {}

class InitialSelectConfigurationState extends SelectConfigurationState {}

class LoadingSelectConfigurationState extends SelectConfigurationState {}

class LoadedSelectConfigurationState extends SelectConfigurationState {}

class SelectedEventState extends SelectConfigurationState {}

class SelectedStandState extends SelectConfigurationState {}

class ConfirmedConfigurationState extends SelectConfigurationState {}

class ErrorSelectConfigurationState extends SelectConfigurationState {
  final String message;

  ErrorSelectConfigurationState(this.message);
}
