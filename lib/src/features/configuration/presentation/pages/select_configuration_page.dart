import 'package:events_time_app_stand/src/features/home_cashier/presentation/home_cashier_page.dart';
import 'package:events_time_app_stand/src/features/shared/presentation/widgets/menu_drawer.dart';
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
  void _confirmConfiguration() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeCashierPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawerWidget(),
      backgroundColor: DSColors.neutral.s100,
      appBar: DSNavBar(
        leading: Builder(
          builder: (BuildContext context) => DSIconButton(
            icon: Icons.menu,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kLayoutSpacerS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: kLayoutSpacerXL),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: DSButtonBar(
        primaryButtonText: 'Confirmar',
        primaryOnPressed: _confirmConfiguration,
      ),
    );
  }
}
