import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectionStatus { online, offline }

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final ConnectionStatus connectionStatus;
  ConnectivityConnected({@required this.connectionStatus});
}

class ConnectivityDisconnected extends ConnectivityState {
  final ConnectionStatus connectionStatus;
  ConnectivityDisconnected({@required this.connectionStatus});
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  ConnectivityCubit({@required this.connectivity})
      : super(ConnectivityInitial()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionStatus.online);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected(ConnectionStatus.offline);
      }
    });
  }

  void emitInternetConnected(ConnectionStatus _connectionStatus) =>
      emit(ConnectivityConnected(connectionStatus: _connectionStatus));

  void emitInternetDisconnected(ConnectionStatus _connectionStatus) =>
      emit(ConnectivityDisconnected(connectionStatus: _connectionStatus));

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
