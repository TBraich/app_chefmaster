import 'package:chefmaster_app/components/bottom_navigator_bar.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/default_button.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String accessKey = prefs.getString('access_token');

              // TODO: handling success Login
              Navigator.popAndPushNamed(context, BottomNavScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
