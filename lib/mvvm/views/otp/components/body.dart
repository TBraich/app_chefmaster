import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/utils/size_config.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  final String phoneNumber;

  const Body({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = new AuthProvider();

    var doResendOTP = () async {
      final Future<Map<String, dynamic>> successfulMessage =
      auth.resendOTP(this.phoneNumber);

      successfulMessage.then((response) {
        if (response['status']) {
          Flushbar(
            title: "Resent OTP",
            message: "We sent a new OTP to your phone!",
            duration: Duration(seconds: durationFlushbar),
          ).show(context);
        } else {
          showAlert(context, response['message'].toString());
        }
      });

    };

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("OTP will be sent to your phone soon... "),
              OtpForm(phoneNumber: this.phoneNumber),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: doResendOTP,
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Row buildTimer() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text("This code will expired in "),
  //       TweenAnimationBuilder(
  //         tween: Tween(begin: 30.0, end: 0.0),
  //         duration: duration,
  //         builder: (_, value, child) => Text(
  //           "00:${value.toInt()}",
  //           style: TextStyle(color: kPrimaryColor),
  //         ),
  //         onEnd: ,
  //       ),
  //     ],
  //   );
  // }
}
