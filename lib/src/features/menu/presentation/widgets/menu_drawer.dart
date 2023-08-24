import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_states.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_store.dart';
import 'package:events_time_microapp_ds/events_time_microapp_ds.dart';
import 'package:flutter/material.dart';

class MenuDrawerWidget extends StatefulWidget {
  const MenuDrawerWidget({super.key});

  @override
  State<MenuDrawerWidget> createState() => _MenuDrawerWidgetState();
}

class _MenuDrawerWidgetState extends State<MenuDrawerWidget> {
  final MenuStore menuStore = AppStand().injector.get();
  late Function() menuStoreListener;

  @override
  void initState() {
    super.initState();
    menuStoreListener = _getMenuStoreListener;
    menuStore.addListener(menuStoreListener);
  }

  @override
  void dispose() {
    menuStore.removeListener(menuStoreListener);
    super.dispose();
  }

  Function() get _getMenuStoreListener => () {
        if (menuStore.value is LogoutDoneMenuState) {
          DSToast.show(
            'Até a próxima!',
            context,
          );
          return;
        }
      };

  void _goToSelectConfiguration() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      SelectConfigurationPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ValueListenableBuilder<MenuState>(
        valueListenable: menuStore,
        child: Container(),
        builder: (BuildContext context, MenuState state, _) {
          final bool isLoading = menuStore.value is LoadingMenuState;

          if (AppStand().userLogged == null) {
            return const CircularProgressIndicator();
          }

          return Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: DSText(
                  AppStand().userLogged!.email,
                  type: DSTextType.BODY_CAPTION,
                ),
                accountName: DSText(
                  '${AppStand().userLogged!.firstName} ${AppStand().userLogged!.lastName}',
                  type: DSTextType.BODY,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: DSColors.primary.base,
                  child: DSText(AppStand().userLogged!.fullNameShortcut,
                      type: DSTextType.HEADING4),
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kComponentSpacerXXL),
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    children: <Widget>[
                      DSNavListItemIcon(
                        title: 'Perfil',
                        onTap: () {},
                        leading: Icons.person_2_outlined,
                      ),
                      if (AppStand().loggedEvent != null &&
                          AppStand().loggedStand != null)
                        DSNavListItemIcon(
                          title: 'Gerenciar estande',
                          onTap: isLoading ? null : () {},
                          leading: Icons.home_outlined,
                        ),
                      DSNavListItemIcon(
                        title: 'Trocar de evento/estande',
                        onTap: isLoading ? null : _goToSelectConfiguration,
                        leading: Icons.swap_horiz_outlined,
                      ),
                      DSNavListItemIcon(
                        title: 'Alterar senha',
                        onTap: isLoading ? null : () {},
                        leading: Icons.password_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kComponentSpacerXXL,
                ),
                child: DSNavListItemIcon(
                  leading: Icons.exit_to_app,
                  title: 'Logout',
                  onTap: isLoading ? null : menuStore.doLogout,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
