import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_states.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:flutter/material.dart';

class MenuStore extends ValueNotifier<MenuState> {
  final ILogoutUsecase logoutUsecase;
  MenuStore({required this.logoutUsecase}) : super(InitialMenuState());

  Future<void> doLogout() async {
    value = LoadingMenuState();
    await logoutUsecase();
    value = LogoutDoneMenuState();
  }
}
