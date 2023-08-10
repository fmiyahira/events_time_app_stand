import 'package:esc_pos_utils/esc_pos_utils.dart';

enum DSPrinterComponentAlign {
  center(PosAlign.center),
  left(PosAlign.left),
  right(PosAlign.right);

  final PosAlign align;

  const DSPrinterComponentAlign(this.align);
}

enum DSPrinterComponentFontType {
  a(PosFontType.fontA),
  b(PosFontType.fontB);

  final PosFontType fontType;

  const DSPrinterComponentFontType(this.fontType);
}

enum DSPrinterComponentQRSize {
  size1(QRSize.Size1),
  size2(QRSize.Size2),
  size3(QRSize.Size3),
  size4(QRSize.Size4),
  size5(QRSize.Size5),
  size6(QRSize.Size6),
  size7(QRSize.Size7),
  size8(QRSize.Size8);

  final QRSize qrSize;

  const DSPrinterComponentQRSize(this.qrSize);
}

enum DSPrinterComponentQRCorrection {
  H(QRCorrection.H),
  L(QRCorrection.L),
  M(QRCorrection.M),
  Q(QRCorrection.Q);

  final QRCorrection correction;

  const DSPrinterComponentQRCorrection(this.correction);
}

enum DSPrinterComponentTextSize {
  size1(PosTextSize.size1),
  size2(PosTextSize.size2),
  size3(PosTextSize.size3),
  size4(PosTextSize.size4),
  size5(PosTextSize.size5),
  size6(PosTextSize.size6),
  size7(PosTextSize.size7),
  size8(PosTextSize.size8);

  final PosTextSize textSize;

  const DSPrinterComponentTextSize(this.textSize);
}

class DSPrinterComponent {
  late Generator generator;
  late CapabilityProfile profile;
  late List<int> _bytes = <int>[];

  Future<void> newPage() async {
    profile = await CapabilityProfile.load();
    generator = Generator(PaperSize.mm58, profile);
    _bytes += generator.setGlobalCodeTable('CP1252');
  }

  List<int> get getContent => _bytes;

  void hr() {
    _bytes += generator.hr();
  }

  void cut() {
    _bytes += generator.hr();
  }

  void emptyLines(int numLines) {
    _bytes += generator.emptyLines(numLines);
  }

  void qrcode(
    String text, {
    DSPrinterComponentAlign align = DSPrinterComponentAlign.left,
    DSPrinterComponentQRSize qrSize = DSPrinterComponentQRSize.size4,
    DSPrinterComponentQRCorrection correction =
        DSPrinterComponentQRCorrection.L,
  }) {
    _bytes += generator.qrcode(
      text,
      align: align.align,
      size: qrSize.qrSize,
      cor: correction.correction,
    );
  }

  void text(
    String text, {
    DSPrinterComponentAlign align = DSPrinterComponentAlign.left,
    DSPrinterComponentFontType fontType = DSPrinterComponentFontType.a,
    DSPrinterComponentTextSize textSize = DSPrinterComponentTextSize.size1,
    bool isBold = false,
    bool withUnderline = false,
  }) {
    _bytes += generator.text(
      text,
      styles: PosStyles(
        align: align.align,
        bold: isBold,
        underline: withUnderline,
        fontType: fontType.fontType,
        height: textSize.textSize,
        width: textSize.textSize,
      ),
    );
  }
}
