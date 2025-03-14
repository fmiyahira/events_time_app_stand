import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_related_events_and_stands_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/controllers/select_configuration_states.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:events_time_microapp_hub/events_time_microapp_hub.dart';
import 'package:flutter/material.dart';

class SelectConfigurationStore extends ValueNotifier<SelectConfigurationState> {
  final IGetRelatedEventsAndStandsUsecase getRelatedEventsAndStandsUsecase;

  RelatedEventsAndStandsModel? releatedEventsAndStandsModel;
  RelatedEventModel? relatedEventModelSelected;
  RelatedStandModel? relatedStandModelSelected;

  bool get validationOk =>
      relatedEventModelSelected != null && relatedStandModelSelected != null;

  SelectConfigurationStore({
    required this.getRelatedEventsAndStandsUsecase,
  }) : super(InitialSelectConfigurationState());

  Future<void> getRelatedEventsAndStands() async {
    value = LoadingSelectConfigurationState();

    try {
      releatedEventsAndStandsModel = await getRelatedEventsAndStandsUsecase();
      relatedEventModelSelected = null;
      relatedStandModelSelected = null;

      value = LoadedSelectConfigurationState();
    } catch (e) {
      value = ErrorSelectConfigurationState(e.toString());
    }
  }

  Future<void> selectEvent(RelatedEventModel relatedEventModel) async {
    relatedEventModelSelected = relatedEventModel;
    relatedStandModelSelected = null;
    value = SelectedEventState();
  }

  Future<void> selectStand(RelatedStandModel relatedStandModel) async {
    relatedStandModelSelected = relatedStandModel;
    value = SelectedStandState();
  }

  Future<void> confirmConfiguration() async {
    value = LoadingConfirmConfigurationState();

    AppStand().loggedEvent = LoggedEventModel.fromMap(
      relatedEventModelSelected!.toMap(),
    );
    AppStand().loggedStand = LoggedStandModel.fromMap(
      relatedStandModelSelected!.toMap(),
    );

    AppStand().hub.send(SaveEventSelectedHubState(AppStand().loggedEvent));
    AppStand().hub.send(SaveStandSelectedHubState(AppStand().loggedStand));

    value = ConfirmedConfigurationState();
  }
}
