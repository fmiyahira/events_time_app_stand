import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/auth/presentation/controllers/splash_states.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';
import 'package:flutter/material.dart';

class SplashStore extends ValueNotifier<SplashState> {
  final IRequesting requesting;
  final IGetSelectedEventUsecase getSelectedEventUsecase;
  final IGetSelectedStandUsecase getSelectedStandUsecase;
  final IGetUserLoggedInfoUsecase getUserLoggedInfoUsecase;

  SplashStore({
    required this.requesting,
    required this.getSelectedEventUsecase,
    required this.getSelectedStandUsecase,
    required this.getUserLoggedInfoUsecase,
  }) : super(InitialSplashState());

  Future<void> verifyIsLogged() async {
    try {
      value = VerifyIsLoggedState();
      final bool isLogged = requesting.hasTokensJWT;

      if (!isLogged) {
        value = NotLoggedState();
        return;
      }

      final UserModel? userLogged = await getUserLoggedInfoUsecase();

      if (userLogged == null) {
        value = NotLoggedState();
        return;
      }

      AppStand().userLogged = userLogged;

      final RelatedEventModel? relatedSelectedEventModel =
          await getSelectedEventUsecase();
      final RelatedStandModel? relatedSelectedStandModel =
          await getSelectedStandUsecase();

      if (relatedSelectedEventModel == null ||
          relatedSelectedStandModel == null) {
        value = LoggedWithoutEventAndStandState();
        return;
      }

      AppStand().selectedEvent = relatedSelectedEventModel;
      AppStand().selectedStand = relatedSelectedStandModel;

      value = LoggedWithEventAndStandState();
    } catch (_) {
      value = NotLoggedState();
    }
  }
}
