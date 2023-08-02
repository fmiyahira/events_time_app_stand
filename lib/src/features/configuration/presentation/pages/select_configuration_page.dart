import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/controllers/select_configuration_states.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/controllers/select_configuration_store.dart';
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
  final SelectConfigurationStore selectConfigurationStore =
      AppStand().injector.get();
  late Function() selectConfigurationStoreListener;

  final TextEditingController controllerSelectStand = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectConfigurationStoreListener = _getSelectConfigurationStoreListener;
    selectConfigurationStore.addListener(selectConfigurationStoreListener);

    selectConfigurationStore.getRelatedEventsAndStands();
  }

  @override
  void dispose() {
    selectConfigurationStore.removeListener(selectConfigurationStoreListener);
    controllerSelectStand.dispose();
    super.dispose();
  }

  Function() get _getSelectConfigurationStoreListener => () {
        if (selectConfigurationStore.value is ErrorSelectConfigurationState) {
          DSDialog(
            type: DSDialogType.ERROR,
            parentContext: context,
            title: 'Falha na busca de eventos e estandes relacionados',
            message: (selectConfigurationStore.value
                    as ErrorSelectConfigurationState)
                .message,
            buttonOnPressed: () => Navigator.of(context).pop(),
            buttonText: 'Ok, entendi',
          ).show();
          return;
        }

        if (selectConfigurationStore.value is ConfirmedConfigurationState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeCashierPage.routeName,
            (_) => false,
          );
          return;
        }
      };

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
          child: ValueListenableBuilder<SelectConfigurationState>(
            valueListenable: selectConfigurationStore,
            builder: (
              BuildContext context,
              SelectConfigurationState state,
              _,
            ) {
              if (state is LoadingSelectConfigurationState) {
                return const CircularProgressIndicator();
              }

              return Column(
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
                    enabled:
                        selectConfigurationStore.releatedEventsAndStandsModel !=
                            null,
                    children: selectConfigurationStore
                            .releatedEventsAndStandsModel?.events
                            .map((RelatedEventModel e) =>
                                <DSSelectKeys, dynamic>{
                                  DSSelectKeys.TITLE: e.name,
                                  DSSelectKeys.VALUE: e.id,
                                })
                            .toList() ??
                        <Map<DSSelectKeys, dynamic>>[],
                    onSelected: (Map<DSSelectKeys, dynamic> value) {
                      // DSSelectKeys.VALUE
                      selectConfigurationStore.selectEvent(
                        selectConfigurationStore
                            .releatedEventsAndStandsModel!.events
                            .firstWhere(
                          (RelatedEventModel e) =>
                              e.id == value[DSSelectKeys.VALUE],
                        ),
                      );

                      controllerSelectStand.text = '';
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: kLayoutSpacerXS),
                  DSSelect(
                    labelText: 'Estande',
                    controller: controllerSelectStand,
                    screenContext: context,
                    enabled:
                        selectConfigurationStore.relatedEventModelSelected !=
                            null,
                    children: selectConfigurationStore
                            .relatedEventModelSelected?.stands
                            .map(
                              (RelatedStandModel s) => <DSSelectKeys, dynamic>{
                                DSSelectKeys.TITLE: s.name,
                                DSSelectKeys.VALUE: s.id,
                              },
                            )
                            .toList() ??
                        <Map<DSSelectKeys, dynamic>>[],
                    onSelected: (Map<DSSelectKeys, dynamic> value) {
                      selectConfigurationStore.selectStand(
                        selectConfigurationStore
                            .relatedEventModelSelected!.stands
                            .firstWhere(
                          (RelatedStandModel s) =>
                              s.id == value[DSSelectKeys.VALUE],
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<SelectConfigurationState>(
        valueListenable: selectConfigurationStore,
        builder: (
          BuildContext context,
          SelectConfigurationState state,
          _,
        ) {
          return DSButtonBar(
            primaryButtonText: 'Confirmar',
            primaryOnPressed: selectConfigurationStore.confirmConfiguration,
            primaryButtonEnabled: selectConfigurationStore.validationOk,
          );
        },
      ),
    );
  }
}
