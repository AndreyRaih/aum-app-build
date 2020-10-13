abstract class NavigatorEvent {
  const NavigatorEvent();
}

class NavigatorPush extends NavigatorEvent {
  final String route;
  final dynamic arguments;
  const NavigatorPush({this.route, this.arguments});
}

class NavigatorPop extends NavigatorEvent {
  const NavigatorPop();
}
