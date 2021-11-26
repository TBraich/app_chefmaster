import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/custom_bottom_nav_bar.dart';
import 'package:chefmaster_app/helper/searchdata.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';

import 'components/body.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = "/mvvm.views.setting";
  const SettingScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey<String>('setting'),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(20.0, 0.0, 0.0),
          child: Text(
            "Setting",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: SearchData());
        })],
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.setting),
    );
  }
}