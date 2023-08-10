import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/ds_printer_component.dart';

Future<List<int>> printAllComponents() async {
  final DSPrinterComponent dsPrinterComponent = DSPrinterComponent();
  await dsPrinterComponent.newPage();
  dsPrinterComponent.text('Textos:', withUnderline: true, isBold: true);
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('Texto padrão');
  dsPrinterComponent.text('Texto negrito', isBold: true);
  dsPrinterComponent.text('Texto com underline', withUnderline: true);
  dsPrinterComponent.text('Texto alinhamento left');
  dsPrinterComponent.text(
    'Texto alinhamento center',
    align: DSPrinterComponentAlign.center,
  );
  dsPrinterComponent.text(
    'Texto alinhamento right',
    align: DSPrinterComponentAlign.right,
  );
  dsPrinterComponent.text('Texto com font A');
  dsPrinterComponent.text(
    'Texto com font B',
    fontType: DSPrinterComponentFontType.b,
  );
  dsPrinterComponent.hr();
  dsPrinterComponent.text('Tamanho textos:', withUnderline: true, isBold: true);
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('Texto tamanho 1');
  dsPrinterComponent.text(
    'Texto tamanho 2',
    textSize: DSPrinterComponentTextSize.size2,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.hr();
  dsPrinterComponent.text('Empty lines:', withUnderline: true, isBold: true);
  dsPrinterComponent.text('Início');
  dsPrinterComponent.emptyLines(1);
  dsPrinterComponent.text('1 linha');
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('2 linha');
  dsPrinterComponent.emptyLines(3);
  dsPrinterComponent.text('3 linha');
  dsPrinterComponent.emptyLines(4);
  dsPrinterComponent.text('4 linha');
  dsPrinterComponent.emptyLines(5);
  dsPrinterComponent.text('5 linha');
  dsPrinterComponent.text('Fim');
  dsPrinterComponent.hr();
  dsPrinterComponent.text('QRCode:', withUnderline: true, isBold: true);
  dsPrinterComponent.text('QRCode padrão alinhamento left:');
  dsPrinterComponent.qrcode('texto 1');
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode padrão alinhamento center:');
  dsPrinterComponent.qrcode('texto 1', align: DSPrinterComponentAlign.center);
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode padrão alinhamento right:');
  dsPrinterComponent.qrcode('texto 1', align: DSPrinterComponentAlign.right);
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode correction H:');
  dsPrinterComponent.qrcode(
    'texto 1',
    correction: DSPrinterComponentQRCorrection.H,
  );
  // dsPrinterComponent.emptyLines(2);
  // dsPrinterComponent.text('QRCode correction L:');
  // dsPrinterComponent.qrcode('texto 1');
  // dsPrinterComponent.emptyLines(2);
  // dsPrinterComponent.text('QRCode correction M:');
  // dsPrinterComponent.qrcode(
  //   'texto 1',
  //   correction: DSPrinterComponentQRCorrection.M,
  // );
  // dsPrinterComponent.emptyLines(2);
  // dsPrinterComponent.text('QRCode correction Q:');
  // dsPrinterComponent.qrcode(
  //   'texto 1',
  //   correction: DSPrinterComponentQRCorrection.Q,
  // );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 1:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size1,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 2:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size2,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 3:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size3,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 4:');
  dsPrinterComponent.qrcode(
    'texto 1',
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 5:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size5,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 6:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size6,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 7:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size7,
  );
  dsPrinterComponent.emptyLines(2);
  dsPrinterComponent.text('QRCode size 8:');
  dsPrinterComponent.qrcode(
    'texto 1',
    qrSize: DSPrinterComponentQRSize.size8,
  );
  dsPrinterComponent.emptyLines(2);

  dsPrinterComponent.text('Cut:');
  dsPrinterComponent.cut();

  return dsPrinterComponent.getContent;
}
