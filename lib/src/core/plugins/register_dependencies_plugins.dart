import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer_impl.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';
import 'package:flutter_simple_bluetooth_printer/flutter_simple_bluetooth_printer.dart';

class RegisterDependenciesPlugins implements IRegisterDependencies {
  @override
  Future<void> register() async {
    AppStand().injector.registerFactory<IBluetoothPrinter>(
          () => BluetoothPrinterImpl(
            bluetoothManager: FlutterSimpleBluetoothPrinter.instance,
          ),
        );
  }
}
