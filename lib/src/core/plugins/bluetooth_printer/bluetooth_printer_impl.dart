// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_bluetooth_printer/flutter_simple_bluetooth_printer.dart';

class BluetoothPrinterImpl implements IBluetoothPrinter {
  final FlutterSimpleBluetoothPrinter bluetoothManager;
  BluetoothPrinterImpl({
    required this.bluetoothManager,
  });

  bool isConnected = false;

  Future<bool> discovery(String address) async {
    final Completer<bool> completer = Completer<bool>();
    final Timer timer = Timer(const Duration(seconds: 5), () {
      completer.complete(false);
    });

    final StreamSubscription<BluetoothDevice> stream =
        bluetoothManager.discovery().listen((
      BluetoothDevice device,
    ) {
      if (kDebugMode) print(device.address);

      if (address == device.address) completer.complete(true);
    }, onError: (Object error) {
      completer.complete(false);
    });

    final bool found = await completer.future;
    if (timer.isActive) timer.cancel();

    bluetoothManager.stopDiscovery();
    stream.cancel();

    return found;
  }

  bool validateAddress(String address) {
    if (address.length < 40 || address.length > 40) return false;
    if (!address.startsWith('E-')) return false;
    if (!address.endsWith('-T')) return false;

    return true;
  }

  String cleanAddress(String address) {
    return address.substring(2, address.length - 2);
  }

  @override
  Future<bool> connectDevice(String address) async {
    try {
      if (!validateAddress(address)) return false;

      final String formattedAddress = cleanAddress(address);

      if (!await discovery(formattedAddress)) return false;

      final bool isSuccess = await bluetoothManager.connect(
        address: formattedAddress,
      );

      if (!isSuccess) return false;
      isConnected = true;
      feed();

      return true;
    } on BTException catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  @override
  Future<void> feed() async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final Generator generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = <int>[];

    bytes += generator.feed(1);
    final Uint8List bytess = Uint8List.fromList(bytes);
    try {
      await bluetoothManager.writeRawData(
        bytess,
        characteristicUuid: 'BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F',
      );
    } on BTException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Future<void> printPage() async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final Generator generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = <int>[];
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.text(
      'EventsTime',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        underline: true,
        fontType: PosFontType.fontA,
      ),
    );
    bytes += generator.text(
      'Voucher - EventsTime',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        underline: true,
        fontType: PosFontType.fontB,
      ),
    );
    bytes += generator.text(
      'Voucher - EventsTime',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        underline: true,
        reverse: true,
      ),
    );
    bytes += generator.text(
      'Voucher - EventsTime',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        underline: true,
      ),
    );
    bytes += generator.hr();
    bytes += generator.text(r'Coca 200ml: R$ 5,00');
    bytes += generator.text('');
    bytes += generator.cut();
    final Uint8List bytess = Uint8List.fromList(bytes);
    try {
      await bluetoothManager.writeRawData(
        bytess,
        characteristicUuid: 'BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F',
      );
    } on BTException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  Future<bool> disconnectDevice() async {
    isConnected = false;
    try {
      return bluetoothManager.disconnect();
    } on BTException catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }
}
