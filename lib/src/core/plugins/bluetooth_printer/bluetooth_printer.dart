import 'dart:async';

abstract class IBluetoothPrinter {
  Future<bool> connectDevice(String address);
  Future<bool> disconnectDevice();
  Future<void> feed();
  Future<void> printPage();
}
