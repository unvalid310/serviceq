import 'package:fluro/fluro.dart';
import 'package:serviceq/utill/routes.dart';
import 'package:serviceq/view/screens/auth/login_screen_email.dart';
import 'package:serviceq/view/screens/dashboard/dashboard_screen.dart';
import 'package:serviceq/view/screens/welcome/welcome_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _loginEmailHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          LoginScreenEmail());
  static Handler _welcomeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => WelcomeScreen());
  static Handler _deshboardHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => DashboardScreen(
            pageIndex: 0,
          ));
  static Handler _dashScreenBoardHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return DashboardScreen(
      pageIndex: params['page'][0] == 'Home'
          ? 0
          : params['page'][0] == 'Rekomendasi'
              ? 1
              : params['page'][0] == 'History'
                  ? 2
                  : params['page'][0] == 'Profile'
                      ? 3
                      : 0,
    );
  });

  static void setupRouter() {
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginEmailHandler,
        transitionType: TransitionType.inFromRight);
    router.define(Routes.WELCOME_SCREEN,
        handler: _welcomeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD,
        handler: _deshboardHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD_SCREEN,
        handler: _dashScreenBoardHandler,
        transitionType: TransitionType.fadeIn); // ?page=home
  }
}
