import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/asana_details/main.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/feedback/main.dart';
import 'package:aum_app_build/views/login/main.dart';
import 'package:aum_app_build/views/onboarding/introduction.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/main.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:aum_app_build/views/progress/main.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/main.dart';
import 'package:aum_app_build/views/practice_preview/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}

final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(AumApp());
}

class AumApp extends StatefulWidget {
  @override
  _AumAppState createState() => _AumAppState();
}

class _AumAppState extends State<AumApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  bool _appIsReady = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Firebase.initializeApp();
    setState(() {
      _appIsReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _appIsReady
        ? MultiBlocProvider(
            providers: [
                BlocProvider<NavigatorBloc>(
                  create: (BuildContext context) =>
                      NavigatorBloc(navigatorKey: _navigatorKey),
                ),
                BlocProvider<UserBloc>(
                  create: (BuildContext context) => UserBloc(
                      navigation: BlocProvider.of<NavigatorBloc>(context)),
                ),
              ],
            child: CupertinoApp(
              initialRoute: '/',
              navigatorKey: _navigatorKey,
              navigatorObservers: [_routeObserver],
              routes: {
                '/': (context) => _InitialScreen(),
                '/login': (context) => RegistrationScreen(),
                '/introduction': (context) => OnboardingIntroductionScreen(),
                '/dashboard': (context) => BlocProvider(
                    create: (context) =>
                        DashboardBloc()..add(DashboardGetPreview()),
                    child: DashboardScreen()),
                '/preview': (context) => BlocProvider(
                      create: (context) => PreviewBloc()..add(InitPreview()),
                      child: PreviewScreen(),
                    ),
                '/progress': (context) => ProgressScreen(),
                '/asana-detail': (context) => AsanaDetailScreen(),
                '/player': (context) => BlocProvider(
                      create: (context) => PlayerBloc(),
                      child: PlayerScreen(),
                    ),
                '/feedback': (context) => FeedbackScreen()
              },
            ))
        : Container();
  }
}

class _InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state == null) {
        makeUserSession(context);
      }
      return Flex(direction: Axis.vertical, children: [
        Expanded(
            child: AumTransition(
          text: 'Aum App',
        ))
      ]);
    });
  }

  void makeUserSession(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(InitializeUserSession());
  }
}
