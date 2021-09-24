import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chefmaster_app/screens/add_recipe/add_recipe_screen.dart';
import 'package:chefmaster_app/screens/app_setting/setting_screen.dart';
import 'package:chefmaster_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:chefmaster_app/screens/fail_screen/faile_404_screen.dart';
import 'package:chefmaster_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:chefmaster_app/screens/home/home_screen.dart';
import 'package:chefmaster_app/screens/list_items/list_items_screen.dart';
import 'package:chefmaster_app/screens/login_success/login_success_screen.dart';
import 'package:chefmaster_app/screens/otp/otp_screen.dart';
import 'package:chefmaster_app/screens/profile_detail/ProfilePage.dart';
import 'package:chefmaster_app/screens/recipe_details/details_screen.dart';
import 'package:chefmaster_app/screens/sign_in/sign_in_screen.dart';
import 'package:chefmaster_app/screens/splash/splash_screen.dart';
import 'package:chefmaster_app/screens/webview/webview_screen.dart';

import 'components/bottom_navigator_bar.dart';
import 'screens/sign_up/sign_up_screen.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    final Animation<Offset> _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, - 4.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    return new SlideTransition(position: _offsetAnimation, child: child);
  }
}

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Fail404Screen.routeName: (context) => Fail404Screen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  BottomNavScreen.routeName: (context) => BottomNavScreen(),
  RecipeDetailsScreen.routeName: (context) => RecipeDetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  ProfilePage.routeName: (context) => ProfilePage(),
  WebViewScreen.routeName: (context) => WebViewScreen(),
  ListItemsScreen.routeName: (context) => ListItemsScreen(),
  CreateNewRecipe.routeName: (context) => CreateNewRecipe(),
};

// We use name route
// All our routes will be available here
final Map<String, Widget> routeWidgets = {
  SplashScreen.routeName: SplashScreen(),
  Fail404Screen.routeName: Fail404Screen(),
  SignInScreen.routeName: SignInScreen(),
  ForgotPasswordScreen.routeName: ForgotPasswordScreen(),
  SignUpScreen.routeName: SignUpScreen(),
  LoginSuccessScreen.routeName: LoginSuccessScreen(),
  CompleteProfileScreen.routeName: CompleteProfileScreen(),
  OtpScreen.routeName: OtpScreen(),
  HomeScreen.routeName: HomeScreen(),
  RecipeDetailsScreen.routeName: RecipeDetailsScreen(),
  // CartScreen.routeName: CartScreen(),
  SettingScreen.routeName: SettingScreen(),
  WebViewScreen.routeName: WebViewScreen(),
  ListItemsScreen.routeName: ListItemsScreen(),
  CreateNewRecipe.routeName: CreateNewRecipe(),
};
