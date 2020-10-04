abstract class NavigatorBlocEvent {
  const NavigatorBlocEvent();
}

class NavigatorBlocPush extends NavigatorBlocEvent {
  final String route;
  final dynamic arguments;
  const NavigatorBlocPush({this.route, this.arguments});
}

class NavigatorBlocPop extends NavigatorBlocEvent {
  const NavigatorBlocPop();
}
