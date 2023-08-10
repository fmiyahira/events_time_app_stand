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

  bool _isConnected = false;
  @override
  set isConnected(bool value) => _isConnected = value;

  @override
  bool get isConnected => _isConnected;

  String _lastPrinterConnected = '';
  @override
  set lastPrinterConnected(String value) => _lastPrinterConnected = value;

  @override
  String get lastPrinterConnected => _lastPrinterConnected;

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
      lastPrinterConnected = address;
      printContent(await feed());

      return true;
    } on BTException catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  @override
  Future<bool> printContent(List<int> bytes) async {
    try {
      return bluetoothManager.writeRawData(
        Uint8List.fromList(bytes),
        characteristicUuid: 'BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F',
      );
    } on BTException catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<List<int>> feed() async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final Generator generator = Generator(PaperSize.mm58, profile);
    return generator.feed(1);
  }

  @override
  Future<bool> disconnectDevice([bool clear = false]) async {
    isConnected = false;
    if (clear) lastPrinterConnected = '';

    try {
      return bluetoothManager.disconnect();
    } on BTException catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }
}
