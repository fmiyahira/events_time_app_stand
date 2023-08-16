import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_states.dart';
import 'package:events_time_microapp_hub/events_time_microapp_hub.dart';
import 'package:flutter/material.dart';

class MenuStore extends ValueNotifier<MenuState> {
  MenuStore() : super(InitialMenuState());

  Future<void> doLogout() async {
    value = LoadingMenuState();

    AppStand().hub.send(LogoutHubState());

    value = LogoutDoneMenuState();
  }
}
