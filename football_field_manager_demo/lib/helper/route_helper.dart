import '../../screens/home_screen.dart';
import '../../screens/init_screen.dart';
import '../../screens/sign_in/sign_in_screen.dart';
import '../../screens/sign_up/sign_up_screen.dart';
import 'package:get/get.dart';

import '../screens/splash/splash_screen.dart';

class RouteHelper {
  static const String initial = "/init";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String enterInfo = "/enter-info";
  static const String home = "/home";
  static const String homeAdmin = "/home-admin";
  static const String infoUser = "/info-user";
  static const String changePassword = "/change-password";
  static const String pickRole = "/pick-role";
  static const String post = "/post";
  static const String message = "/message";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getEnterInfo() => enterInfo;
  static String getHomeRoute() => home;
  static String getInfoUserRoute() => infoUser;
  static String getChangePassword() => changePassword;
  static String getPostRoute() => post;
  static String getMessage() => message;
  static String getPickRole() => pickRole;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreent()),
    // GetPage(name: enterInfo, page: () => EnterInfoScreen()),
    GetPage(name: initial, page: () => InitScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
