
abstract class NetworkInfo {
  bool isConnected();
}


class NetworkInfoImpl implements NetworkInfo {
  @override
  bool isConnected() {
    return true;
  }
}