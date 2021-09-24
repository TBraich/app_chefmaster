import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';


import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  final String email;
  final String password;

  Body(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text("Complete Profile", style: headingStyle),
                Text(
                  "Complete your details or continue  \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                CompleteProfileForm(this.email, this.password),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
