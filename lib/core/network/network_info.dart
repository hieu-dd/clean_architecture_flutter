import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  bool isConnected();
}

@Singleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  bool isConnected() {
    return true;
  }
}
