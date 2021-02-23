import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator/navigator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorBlocState> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey}) : super(null);

  @override
  Stream<NavigatorBlocState> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigatorPush) {
      navigatorKey.currentState.pushNamed(event.route, arguments: event.arguments);
    }
  }
}
