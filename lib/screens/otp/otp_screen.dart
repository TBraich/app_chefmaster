import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final OtpScreenArguments otpArgs =
    ModalRoute.of(context).settings.arguments as OtpScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(phoneNumber: otpArgs.phoneNumber),
    );
  }
}

class OtpScreenArguments {
  final String phoneNumber;

  OtpScreenArguments(this.phoneNumber);
}
