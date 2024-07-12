import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetConnectionCubit extends Cubit<bool> {
  late StreamSubscription<InternetStatus> _internetSubscription;

  NetConnectionCubit() : super(false) {
    _internetSubscription = InternetConnection().onStatusChange.listen(
      (status) {
        emit(status == InternetStatus.connected);
      },
    );
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    return super.close();
  }
}
