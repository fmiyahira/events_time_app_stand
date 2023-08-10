import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/ds_printer_component_mock.dart';
import 'package:events_time_app_stand/src/core/plugins/scanner_qrcode/scanner_qrcode.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/widgets/menu_drawer.dart';
import 'package:events_time_microapp_ds/events_time_microapp_ds.dart';
import 'package:flutter/material.dart';

class HomeCashierPage extends StatefulWidget {
  static String routeName = '/home_cashier';

  const HomeCashierPage({super.key});

  @override
  State<HomeCashierPage> createState() => _HomeCashierPageState();
}

class _HomeCashierPageState extends State<HomeCashierPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScannerQRCode scannerQRCode;
  final IBluetoothPrinter bluetoothPrinter = AppStand().injector.get();

  @override
  void reassemble() {
    super.reassemble();
    scannerQRCode.reassemble();
  }

  @override
  void initState() {
    super.initState();

    scannerQRCode = ScannerQRCode();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    scannerQRCode.dispose();
    super.dispose();
  }

  Future<void> _newShoppingCart() async {
    await bluetoothPrinter.printContent(await printAllComponents());
  }

  Future<void> _showConfigurePrinterBottomSheet() async {
    await bluetoothPrinter.disconnectDevice();
    DSBottomSheet(
      screenContext: context,
      title: 'Ler QR-Code da impressora',
      child: scannerQRCode.view((Barcode barcode) async {
        await bluetoothPrinter.connectDevice(barcode.code!);

        Navigator.of(context).pop();
        DSDialog(
          parentContext: context,
          title: 'QR-CODE',
          message: barcode.code!,
          buttonText: 'OK',
          buttonOnPressed: () => Navigator.of(context).pop(),
        ).show();
      }, context),
    ).show();
  }

  void _showVoucherScannerBottomSheet() {
    DSBottomSheet(
      screenContext: context,
      title: 'Ler QR-Code do Voucher',
      child: scannerQRCode.view((Barcode barcode) {
        Navigator.of(context).pop();
        DSDialog(
          parentContext: context,
          title: 'QR-CODE',
          message: barcode.code!,
          buttonText: 'OK',
          buttonOnPressed: () => Navigator.of(context).pop(),
        ).show();
      }, context),
    ).show();
  }

  void _showDialogCancelSale() {
    DSConfirmDialog(
      type: DSDialogType.WARNING,
      title: 'Cancelar venda',
      parentContext: context,
      message: 'Confirma cancelamento da venda?',
      primaryButtonText: 'Confirmar',
      primaryOnPressed: () {
        Navigator.of(context).pop();
      },
      secondaryButtonText: 'Fechar',
      secondaryOnPressed: () {
        Navigator.of(context).pop();
      },
      label: 'Uma vez cancelada, todos os vouchers emitidos serão invalidados',
    ).show();
  }

  void _showDialogReprintVouchers() {
    DSConfirmDialog(
      type: DSDialogType.INFO,
      title: 'Reimpressão de vouchers',
      parentContext: context,
      message: 'Confirma reimpressão dos vouchers?',
      primaryButtonText: 'Confirmar',
      primaryOnPressed: () {
        Navigator.of(context).pop();
      },
      secondaryButtonText: 'Fechar',
      secondaryOnPressed: () {
        Navigator.of(context).pop();
      },
    ).show();
  }

  Widget _buildReserveVoucherItemNotUsed() {
    return Container(
      color: DSColors.neutral.s100,
      padding: const EdgeInsets.symmetric(
        horizontal: kComponentSpacerL,
        vertical: kComponentSpacerM,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: DSCheckbox(
                label: '#1245',
                caption: r'R$ 30,00',
                onChange: (bool checked) {},
              ),
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     DSText(
          //       '#1245',
          //       type: DSTextType.BODY,
          //       theme: DSTextTheme(
          //         fontWeight: FontWeight.bold,
          //         textColor: DSColors.neutral.s46,
          //       ),
          //     ),
          //     DSText(
          //       r'R$ 30,00',
          //       type: DSTextType.BODY_CAPTION,
          //     ),
          //   ],
          // ),
          const SizedBox(width: kLayoutSpacerXS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                DSText(
                  'Hayhay Sushi',
                  type: DSTextType.BODY_CAPTION,
                  overflow: TextOverflow.ellipsis,
                ),
                DSText(
                  'Yakiniku',
                  type: DSTextType.BODY_CAPTION,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReserveVoucherItemUsed() {
    return Container(
      color: DSColors.neutral.s100,
      padding: const EdgeInsets.symmetric(
        horizontal: kComponentSpacerL,
        vertical: kComponentSpacerM,
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DSText(
                '#1245',
                type: DSTextType.BODY,
                theme: DSTextTheme(
                  fontWeight: FontWeight.bold,
                  textColor: DSColors.neutral.s46,
                ),
              ),
              DSText(
                'Hayhay Sushi',
                type: DSTextType.BODY_CAPTION,
              ),
            ],
          ),
          const SizedBox(width: kLayoutSpacerXS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DSText(
                  'ÁGUA POR DO SOL COM GAS 510ML',
                  type: DSTextType.BODY_CAPTION,
                  overflow: TextOverflow.ellipsis,
                ),
                DSText(
                  r'07/08 18:00h',
                  type: DSTextType.BODY_SMALLER,
                ),
              ],
            ),
          ),
          const SizedBox(width: kLayoutSpacerXS),
          Column(
            children: <Widget>[
              DSText(
                r'R$ 30,00',
                type: DSTextType.BODY_CAPTION,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReserveBottomSheet() {
    DSBottomSheet(
      title: 'Estornar vouchers / #1020',
      size: DSBottomSheetSize.LARGE,
      screenContext: context,
      scrollEnabled: false,
      useDefaultPadding: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: DSDeviceSpacer.getDeviceSpacer(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // DSText(
                      //   'Vouchers da venda',
                      //   type: DSTextType.HEADING4,
                      // ),
                      // const SizedBox(
                      //   height: kLayoutSpacerXXS,
                      // ),
                      DSText(
                        'Selecione os vouchers que deseja estornar, não é possível a seleção de vouchers já utilizados.',
                        type: DSTextType.BODY_CAPTION,
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: tabController,
                  labelColor: DSColors.neutral.s24,
                  indicatorColor: DSColors.primary.base,
                  tabs: const <Widget>[
                    Tab(text: 'NÃO utilizados'),
                    Tab(text: 'Utilizados'),
                  ],
                ),
                Expanded(
                  child: ColoredBox(
                    color: DSColors.neutral.s96,
                    child: Stack(
                      children: <Widget>[
                        DSDivider(),
                        TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            ListView.separated(
                              padding: const EdgeInsets.all(kComponentSpacerS),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: kComponentSpacerS),
                              itemBuilder: (BuildContext context, int index) {
                                return _buildReserveVoucherItemNotUsed();
                              },
                              itemCount: 8,
                            ),
                            ListView.separated(
                              padding: const EdgeInsets.all(kComponentSpacerS),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: kComponentSpacerS),
                              itemBuilder: (BuildContext context, int index) {
                                return _buildReserveVoucherItemUsed();
                              },
                              itemCount: 8,
                            )
                          ],
                        ),
                        Positioned(
                          bottom: kComponentSpacerXXL,
                          right: kComponentSpacerXXL,
                          child: FloatingActionButton(
                            backgroundColor: DSColors.primary.base,
                            child: const Icon(Icons.qr_code_2_outlined),
                            onPressed: () {
                              _showVoucherScannerBottomSheet();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DSButtonBar.withText(
            primaryButtonText: 'Estornar',
            primaryOnPressed: () {},
            value: r'R$ 60,00',
            caption: 'Total estornado',
          ),
        ],
      ),
    ).show();
  }

  void _showSaleOptions() {
    DSBottomSheet(
      title: 'Venda #1020',
      screenContext: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DSLinkButton(
            text: 'Visualizar detalhes',
          ),
          DSDivider(),
          DSLinkButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showDialogReprintVouchers();
            },
            text: 'Reimprimir vouchers',
          ),
          DSDivider(),
          DSLinkButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showReserveBottomSheet();
            },
            text: 'Estornar vouchers',
          ),
          DSDivider(),
          DSLinkButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showDialogCancelSale();
            },
            text: 'Cancelar venda',
          ),
        ],
      ),
    ).show();
  }

  Widget _listItem(Color color) {
    return InkWell(
      onTap: _showSaleOptions,
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kPillBorderRaius),
                  bottomLeft: Radius.circular(kPillBorderRaius),
                ),
              ),
              width: kComponentSpacerS,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kComponentSpacerL,
                  vertical: kComponentSpacerM,
                ),
                color: DSColors.neutral.s100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DSText(
                          '#1020',
                          type: DSTextType.BODY,
                          theme: DSTextTheme(
                            fontWeight: FontWeight.bold,
                            textColor: DSColors.neutral.s46,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kComponentSpacerS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DSText(
                          r'Valor total: R$ 20,00',
                          type: DSTextType.BODY_CAPTION,
                        ),
                        DSText(
                          'há 2min',
                          type: DSTextType.BODY_SMALLER,
                        ),
                      ],
                    ),
                    const SizedBox(height: kComponentSpacerXS),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawerWidget(),
      backgroundColor: DSColors.neutral.s100,
      appBar: DSNavBar(
        actions: <Widget>[
          DSIconButton(icon: Icons.tune_outlined, onPressed: () {}),
          DSIconButton(
            icon: Icons.print_disabled,
            onPressed: _showConfigurePrinterBottomSheet,
            theme: DSIconButtonTheme(
              iconColor: DSColors.error.base,
            ),
          ),
        ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kLayoutSpacerS),
              child: DSText(
                'Listagem de vendas',
                type: DSTextType.HEADING2,
              ),
            ),
            const SizedBox(height: kLayoutSpacerS),
            DSDivider(),
            Expanded(
              child: ColoredBox(
                color: DSColors.neutral.s96,
                child: ListView.separated(
                  padding: const EdgeInsets.all(kComponentSpacerS),
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: kComponentSpacerS),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) => _listItem(
                      index / 5 == 0
                          ? DSColors.warning.light
                          : DSColors.success.light),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DSButtonBar(
        primaryButtonText: 'Novo Carrinho',
        primaryOnPressed: _newShoppingCart,
      ),
    );
  }
}
