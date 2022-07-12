import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/network_connectivity_status.dart';


abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final NetworkConnectionStatus connectionStatus;
  ConnectivityConnected({required this.connectionStatus});
}

class ConnectivityDisconnected extends ConnectivityState {
  final NetworkConnectionStatus connectionStatus;
  ConnectivityDisconnected({required this.connectionStatus});
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  late final Connectivity connectivity;
 late StreamSubscription connectivityStreamSubscription;

  ConnectivityCubit({required this.connectivity})
      : super(ConnectivityInitial()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(NetworkConnectionStatus.online);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected(NetworkConnectionStatus.offline);
      }
    });
  }

  void emitInternetConnected(NetworkConnectionStatus _connectionStatus) =>
      emit(ConnectivityConnected(connectionStatus: _connectionStatus));

  void emitInternetDisconnected(NetworkConnectionStatus _connectionStatus) =>
      emit(ConnectivityDisconnected(connectionStatus: _connectionStatus));

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
