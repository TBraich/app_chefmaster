import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/views/fail_screen/faile_404_screen.dart';
import 'package:chefmaster_app/utils/constants.dart';

import 'profile_menu.dart';
import '../../profile_detail/components/profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //     child: SizedBox(
          //         height: 120,
          //         width: 120,
          //         child: Text("avatar", textAlign: TextAlign.center))),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Notifications",
            icon: Icon(
              Icons.notifications_none,
              color: kPrimaryColor,
            ),
            press: () {
              Navigator.pushNamed(context, Fail404Screen.routeName);
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icon(
              Icons.settings,
              color: kPrimaryColor,
            ),
            press: () {
              Navigator.pushNamed(context, Fail404Screen.routeName);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: Icon(
              Icons.help_center_outlined,
              color: kPrimaryColor,
            ),
            press: () {
              Navigator.pushNamed(context, Fail404Screen.routeName);
            },
          ),
          ProfileMenu(
            text: "About Us",
            icon: Icon(
              Icons.info_outline_rounded,
              color: kPrimaryColor,
            ),
            press: () => {Navigator.pushNamed(context, Fail404Screen.routeName)},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
            press: () async {
              showConfirmationAlert(context);
            },
          ),
        ],
      ),
    );
  }
}
