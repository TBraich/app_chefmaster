import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:chefmaster_app/components/loading_indicator.dart';
import 'package:chefmaster_app/models/User.dart';
import 'package:chefmaster_app/screens/sign_in/sign_in_screen.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kOppositePrimaryColor = Color(0xFF0089bc);
const kPrimaryLightColor = Color(0xFFFCCD92);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp phoneValidatorRegExp = RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b');
final RegExp passwordRegExp =
    RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kInvalidPassError =
    "Passwords must have at least 8 letters, 1 Upper + Lower + Special + Number";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kInvalidPhoneNumberError = "Please Enter Valid phone number";
const String kAddressNullError = "Please Enter your address";
const String kInvalidBirthdayError = "Please provide a valid datetime";

const String PrefKeepLogin = "keep_login";
const String PrefAccessToken = "access_token";

const String PrefGotUserInfo = "got_user_info";

// UserInfo Pref
const String PrefUserID = "user_id";
const String PrefUserName = "user_name";
const String PrefUserSurname = "user_surname";
const String PrefUserPhone = "user_phone";
const String PrefUserEmail = "user_email";
const String PrefUserAddress = "user_address";
const String PrefUserImageURL = "user_image_url";
const String PrefUserBirthday = "user_birthday";

const int durationFlushbar = 4;
BoxShadow kBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 2,
  blurRadius: 8,
  offset: Offset(0, 0),
);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

showConfirmationAlert(BuildContext context) async {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Do you want to logout?"),
      content: Text("You will lost all data."),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BasicDialogAction(
          title: Text("Logout"),
          onPressed: () async {
            Navigator.pop(context);
            showLoadingIndicator(context);
            await Future.delayed(Duration(milliseconds: 200));
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            hideOpenDialog(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
                SignInScreen.routeName, (Route<dynamic> route) => false);
          },
        ),
      ],
    ),
  );
}

showAlert(BuildContext context, String msg) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Something when wrong!"),
      content: Text(msg),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

void showLoadingIndicator(BuildContext context, [String text]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingIndicator();
    },
  );
}

void hideOpenDialog(BuildContext context) {
  Navigator.of(context).pop();
}

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

void saveDataUser({SharedPreferences prefs, String userId, String userName, String userSurname, String email, String phoneNumber, int birthday, String address, String imageUrl}) {
  prefs.setString(PrefUserID, userId);
  prefs.setString(PrefUserName, userName);
  prefs.setString(PrefUserSurname, userSurname);
  prefs.setString(PrefUserEmail, email);
  prefs.setString(PrefUserPhone, phoneNumber);
  prefs.setInt(PrefUserBirthday, birthday);
  prefs.setString(PrefUserAddress, address);
  prefs.setString(PrefUserImageURL, imageUrl);
}

Future<User> getDataUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = new User(
      userID: prefs.getString(PrefUserID),
      userName: prefs.getString(PrefUserName),
      userSurname: prefs.getString(PrefUserSurname),
      email: prefs.getString(PrefUserEmail),
      phoneNumber: prefs.getString(PrefUserPhone),
      address:  prefs.getString(PrefUserAddress),
      imageUrl: prefs.getString(PrefUserImageURL),
      birthday: prefs.getInt(PrefUserBirthday));

  return user;
}