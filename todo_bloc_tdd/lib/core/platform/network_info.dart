import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<DataConnectionStatus> get connectionStatus;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  Future<DataConnectionStatus> get connectionStatus =>
      connectionChecker.connectionStatus;
}
