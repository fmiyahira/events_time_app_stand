import 'dart:async';

abstract class IBluetoothPrinter {
  set isConnected(bool value);
  bool get isConnected;
  set lastPrinterConnected(String value);
  String get lastPrinterConnected;

  Future<bool> connectDevice(String address);
  Future<bool> disconnectDevice();
  Future<bool> printContent(List<int> bytes);
}
