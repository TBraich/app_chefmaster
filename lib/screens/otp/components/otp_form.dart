import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/default_button.dart';
import 'package:chefmaster_app/helper/keyboard.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/screens/login_success/login_success_screen.dart';
import 'package:chefmaster_app/utils/size_config.dart';

import '../../../utils/constants.dart';

class OtpForm extends StatefulWidget {
  final String phoneNumber;

  const OtpForm({Key key, this.phoneNumber}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState(this.phoneNumber);
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  final String phoneNumber;

  String otp = "";
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  _OtpFormState(this.phoneNumber);

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      otp += value;
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = new AuthProvider();
    final form = _formKey.currentState;

    var doVerify = () async {
      KeyboardUtil.hideKeyboard(context);
      final Future<Map<String, dynamic>> successfulMessage =
          auth.verifyOTP(otp, this.phoneNumber);

      successfulMessage.then((response) {
        if (response['status']) {
          Navigator.pushReplacementNamed(context, LoginSuccessScreen.routeName);
        } else {
          showAlert(context, response['message'].toString());
        }
      });

      setState(() {
        otp = "";
      });
      print("===> otp: " + otp);
      form.reset();
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin6FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                      otp += value;
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: doVerify,
          )
        ],
      ),
    );
  }
}
