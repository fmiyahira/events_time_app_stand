import 'package:events_time_app_stand/src/features/auth/presentation/pages/login_page.dart';
import 'package:events_time_microapp_ds/events_time_microapp_ds.dart';
import 'package:flutter/material.dart';

class SelectConfigurationPage extends StatefulWidget {
  static String routeName = '/select_configuration';

  const SelectConfigurationPage({super.key});

  @override
  State<SelectConfigurationPage> createState() =>
      _SelectConfigurationPageState();
}

class _SelectConfigurationPageState extends State<SelectConfigurationPage> {
  void _doLogout() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (_) => false,
    );
  }

  void _confirmConfiguration() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.neutral.s100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kLayoutSpacerS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DSText(
                'Configuração',
                type: DSTextType.HEADING2,
              ),
              const SizedBox(height: kLayoutSpacerXXXS),
              DSText(
                'Selecione o evento e estande',
                type: DSTextType.BODY,
              ),
              const SizedBox(height: kLayoutSpacerM),
              DSSelect(
                labelText: 'Evento',
                screenContext: context,
                children: const <Map<DSSelectKeys, dynamic>>[
                  <DSSelectKeys, dynamic>{
                    DSSelectKeys.TITLE: '4º Festival do Japão',
                    DSSelectKeys.VALUE: 1,
                  },
                  <DSSelectKeys, dynamic>{
                    DSSelectKeys.TITLE: '12º Bon-odori',
                    DSSelectKeys.VALUE: '2',
                  },
                ],
                onSelected: (Map<DSSelectKeys, dynamic> value) {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: kLayoutSpacerXS),
              DSSelect(
                labelText: 'Estande',
                screenContext: context,
                children: const <Map<DSSelectKeys, dynamic>>[
                  <DSSelectKeys, dynamic>{
                    DSSelectKeys.TITLE: 'Caixa',
                    DSSelectKeys.VALUE: 1,
                  },
                  <DSSelectKeys, dynamic>{
                    DSSelectKeys.TITLE: 'Bebidas',
                    DSSelectKeys.VALUE: 2,
                  },
                  <DSSelectKeys, dynamic>{
                    DSSelectKeys.TITLE: 'Sobá',
                    DSSelectKeys.VALUE: 3,
                  },
                ],
                onSelected: (Map<DSSelectKeys, dynamic> value) {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: kLayoutSpacerS),
              DSButton(
                size: DSButtonSize.SMALL,
                text: 'Confirmar',
                buttonStyle: DSButtonStyle.PRIMARY,
                onPressed: _confirmConfiguration,
              ),
              DSLinkButton(
                size: DSLinkButtonSize.SMALL,
                text: 'Acessar com outro usuário',
                textType: DSInteractiveTextType.ACTION_SMALL,
                onPressed: _doLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
