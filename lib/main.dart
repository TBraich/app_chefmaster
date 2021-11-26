import 'package:chefmaster_app/mvvm/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/routes.dart';
import 'package:chefmaster_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/bottom_navigator_bar.dart';
import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool(PrefKeepLogin) ?? false;

  runApp(MyApp(
    routeName: status == true ? BottomNavScreen.routeName : SplashScreen.routeName,
  ));
}

class MyApp extends StatelessWidget {
  final String routeName;

  const MyApp({Key key, this.routeName}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // We use routeName so that we dont need to remember the name
      initialRoute: routeName,
      routes: routes,
      // onGenerateRoute: (settings) {
      //   return PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => routeWidgets[routeName],
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       const begin = Offset(0.0, 1.0);
      //       const end = Offset.zero;
      //       const curve = Curves.ease;
      //
      //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //
      //       return SlideTransition(
      //         position: animation.drive(tween),
      //         child: child,
      //       );
      //     },
      //   );
      // },
      // home: BottomNavScreen()
    );
  }
}
