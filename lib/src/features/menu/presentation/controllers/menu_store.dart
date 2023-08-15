import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_states.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:flutter/material.dart';

class MenuStore extends ValueNotifier<MenuState> {
  final ILogoutUsecase logoutUsecase;
  final IDeleteSelectedEventUsecase deleteSelectedEventUsecase;
  final IDeleteSelectedStandUsecase deleteSelectedStandUsecase;

  MenuStore({
    required this.logoutUsecase,
    required this.deleteSelectedEventUsecase,
    required this.deleteSelectedStandUsecase,
  }) : super(InitialMenuState());

  Future<void> doLogout() async {
    value = LoadingMenuState();

    await deleteSelectedEventUsecase();
    await deleteSelectedStandUsecase();
    await logoutUsecase();
    value = LogoutDoneMenuState();
  }
}
