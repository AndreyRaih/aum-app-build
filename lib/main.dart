import 'package:aum_app_build/common_bloc/login/login_cubit.dart';
import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_cubit.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/asana_details/main.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/feedback/main.dart';
import 'package:aum_app_build/views/login/main.dart';
import 'package:aum_app_build/views/onboarding/concept.dart';
import 'package:aum_app_build/views/onboarding/player.dart';
import 'package:aum_app_build/views/player/bloc/player_bloc.dart';
import 'package:aum_app_build/views/player/main.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_cubit.dart';
import 'package:aum_app_build/views/progress/main.dart';
import 'package:aum_app_build/views/shared/transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/main.dart';
import 'package:aum_app_build/views/practice_preview/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void onError(bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}

final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

void main() {
  Bloc.observer = SimpleBlocObserver();
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
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
                BlocProvider<NavigatorCubit>(
                  create: (BuildContext context) => NavigatorCubit(navigatorKey: _navigatorKey),
                ),
                BlocProvider<UserBloc>(
                  create: (BuildContext context) => UserBloc(navigation: BlocProvider.of<NavigatorCubit>(context)),
                ),
                BlocProvider<LoginCubit>(create: (BuildContext context) => LoginCubit())
              ],
            child: CupertinoApp(
              initialRoute: '/',
              navigatorKey: _navigatorKey,
              navigatorObservers: [_routeObserver],
              routes: {
                // Initial & Login
                INITIAL_ROUTE_NAME: (context) => _InitialScreen(),
                LOGIN_ROUTE_NAME: (context) => RegistrationScreen(),
                // Onboarding flow
                CONCEPT_ONBOARDING_ROUTE_NAME: (context) => BlocProvider<OnboardingCubit>(
                    create: (BuildContext context) => OnboardingCubit(), child: OnboardingConceptScreen()),
                PLAYER_ONBOARDING_ROUTE_NAME: (context) => BlocProvider<OnboardingCubit>(
                    create: (BuildContext context) => OnboardingCubit(), child: OnboardingPlayerScreen()),
                // Practice flow
                DASHBOARD_ROUTE_NAME: (context) => BlocProvider(
                    create: (context) => DashboardBloc()..add(DashboardInitialise()), child: DashboardScreen()),
                PREVIEW_ROUTE_NAME: (context) => BlocProvider(
                      create: (context) => PreviewCubit(),
                      child: PreviewScreen(ModalRoute.of(context).settings.arguments),
                    ),
                PLAYER_ROUTE_NAME: (context) => BlocProvider(
                      create: (context) => PlayerBloc(navigation: BlocProvider.of<NavigatorCubit>(context)),
                      child: PlayerScreen(ModalRoute.of(context).settings.arguments),
                    ),
                FEEDBACK_ROUTE_NAME: (context) => BlocProvider(
                    create: (context) => PlayerBloc(navigation: BlocProvider.of<NavigatorCubit>(context)),
                    child: FeedbackScreen()),
                // Progress flow
                PROGRESS_ROUTE_NAME: (context) => ProgressScreen(),
                DETAILS_ROUTE_NAME: (context) => AsanaDetailScreen(),
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
    BlocProvider.of<UserBloc>(context).add(StartUserSession());
  }
}
