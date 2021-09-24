import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:chefmaster_app/components/no_account_text.dart';
import 'package:chefmaster_app/components/socal_card.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/screens/login_success/login_success_screen.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {

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
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () async {
                        await loginWithFacebookAccount(context);
                      },
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginWithFacebookAccount(BuildContext context) async {
    // final AccessToken accessToken = await FacebookAuth.instance.accessToken;
    // // or FacebookAuth.i.accessTokenAw
    // if (accessToken != null) {
    //   // user is logged
    //   Navigator.pushReplacementNamed(
    //       context, LoginSuccessScreen.routeName);
    // } else {
    //   final LoginResult result = await FacebookAuth.instance
    //       .login(); // by default we request the email and the public profile
    //   // or FacebookAuth.i.login()
    //   if (result.status == LoginStatus.success) {
    //     // you are logged
    //     final AccessToken accessToken = result.accessToken;
    //     Navigator.pushReplacementNamed(
    //         context, LoginSuccessScreen.routeName);
    //   }
    // }
  }
}
