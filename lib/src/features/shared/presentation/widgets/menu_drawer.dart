import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_microapp_ds/events_time_microapp_ds.dart';
import 'package:flutter/material.dart';

class MenuDrawerWidget extends StatefulWidget {
  const MenuDrawerWidget({super.key});

  @override
  State<MenuDrawerWidget> createState() => _MenuDrawerWidgetState();
}

class _MenuDrawerWidgetState extends State<MenuDrawerWidget> {
  void _doLogout() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/auth/login',
      (_) => false,
    );
  }

  void _goToSelectConfiguration() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      SelectConfigurationPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: DSText(
              'miyahirafernando@gmail.com',
              type: DSTextType.BODY_CAPTION,
            ),
            accountName: DSText(
              'Fernando Augusto Miyahira',
              type: DSTextType.BODY,
            ),
            currentAccountPicture: CircleAvatar(
              child: DSText('FM', type: DSTextType.HEADING4),
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kComponentSpacerXXL),
              child: ListView(
                // Important: Remove any padding from the ListView.
                children: <Widget>[
                  DSNavListItemIcon(
                    title: 'Perfil',
                    onTap: () {},
                    leading: Icons.person_2_outlined,
                  ),
                  DSNavListItemIcon(
                    title: 'Gerenciar estande',
                    onTap: () {},
                    leading: Icons.home_outlined,
                  ),
                  DSNavListItemIcon(
                    title: 'Trocar de evento/estande',
                    onTap: _goToSelectConfiguration,
                    leading: Icons.swap_horiz_outlined,
                  ),
                  DSNavListItemIcon(
                    title: 'Alterar senha',
                    onTap: () {},
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
              onTap: _doLogout,
            ),
          ),
        ],
      ),
    );
  }
}
