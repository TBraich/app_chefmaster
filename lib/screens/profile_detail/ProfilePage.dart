import 'dart:core';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/custom_bottom_nav_bar.dart';
import 'package:chefmaster_app/components/submit_buttons.dart';
import 'package:chefmaster_app/screens/profile_detail/components/profile_pic.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:chefmaster_app/components/custom_app_bar.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static final String routeName = "/screens.profile_detail";

  const ProfilePage();

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool _gotData = false;
  final FocusNode myFocusNode = FocusNode();
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  String email = "";
  String birthDay = "2000-01-01";

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return !_gotData
        ? Scaffold()
        : Scaffold(
            appBar: CustomAppBar(
              optsWidget: _status
                  ? _getEditIcon(icon: Icons.edit)
                  : _getEditIcon(icon: Icons.cancel_outlined),
              label: '',
              backOpt: BackOpt.NotNeedBack,
            ),
            // bottomNavigationBar:
            //     CustomBottomNavBar(selectedMenu: MenuState.profile),
            body: ListView(
              children: [
                Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ProfilePic(),
                        SizedBox(height: 25),
                        Text(
                          "PERSONAL PROFILE",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Flexible(
                                  child: _profileEditText(
                                      "Name", "Enter Your Name",
                                      margin: EdgeInsets.only(
                                          right: 5, left: 20.0, top: 14),
                                      initValue: name),
                                  flex: 2,
                                ),
                                Flexible(
                                  child: _profileEditText(
                                      "Surname", "Enter Your Surname",
                                      margin: EdgeInsets.only(
                                          right: 20.0, left: 5, top: 14),
                                      initValue: surname),
                                  flex: 3,
                                )
                              ],
                            ),
                            _profileEditText("Email", "Enter Your Email",
                                initValue: email, enabled: false, autoClear: false),
                            _profileEditText("Phone Number", "Enter Your Phone",
                                initValue: phone, enabled: false, autoClear: false),
                            _profileEditText("Address", "Enter Your Address",
                                initValue: address),
                            buildDateTimeField(),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        )
                      ],
                    ))
              ],
            ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _profileEditText(String label, String hint,
      {EdgeInsets margin, bool enabled, String initValue, bool autoClear = true}) {
    var _controller = TextEditingController(text: initValue);
    return Container(
      margin: margin != null
          ? margin
          : EdgeInsets.only(right: 20.0, left: 20.0, top: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: _controller,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                hintText: hint,
                suffixIcon: !_status&&autoClear
                    ? IconButton(
                        onPressed: _controller.clear,
                        icon: Icon(Icons.clear),
                      )
                    : SizedBox(),
                contentPadding: EdgeInsets.only(left: 20, right: 20)),
            enabled: enabled != null ? enabled : !_status,
            autofocus: !_status,
          )
        ],
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 15.0),
      child: Container(
          margin: EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: GestureDetector(
            child: new Text("Save",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            onTap: () {
              setState(() {
                _status = true;
                FocusScope.of(context).requestFocus(new FocusNode());
              });
            },
          )),
    );
  }

  Widget _getEditIcon({@required IconData icon}) {
    return GestureDetector(
      child: SizedBox(
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        child: Icon(icon),
      ),
      onTap: () {
        setState(() {
          _status = !_status;
        });
      },
    );
  }

  Widget buildDateTimeField() {
    DateTime beforeYear = DateTime(1940);
    DateTime afterYear = DateTime(2021);
    return birthDay == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BirthDay",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                DateTimeField(
                  autofocus: true,
                  enableInteractiveSelection: false,
                  validator: (value) {
                    if (value.isBefore(beforeYear) ||
                        value.isAfter(afterYear)) {
                      return "Your birthday is not valid";
                    }
                    return null;
                  },
                  format: DateFormat("yyyy-MM-dd"),
                  onSaved: (newValue) => birthDay = newValue.toString(),
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: DateTime.parse(birthDay),
                        lastDate: DateTime(2100));
                    return date;
                  },
                  enabled: !_status,
                  initialValue: DateTime.parse(birthDay),
                  decoration: _status
                      ? InputDecoration(
                          hintText: "Enter the day you're born",
                          suffixIcon: SizedBox(),
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          contentPadding: EdgeInsets.only(left: 20, right: 20))
                      : null,
                ),
              ],
            ),
          );
  }

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString(PrefUserName);
      surname = pref.getString(PrefUserSurname);
      email = pref.getString(PrefUserEmail);
      address = pref.getString(PrefUserAddress);
      phone = pref.getString(PrefUserPhone);
      birthDay = pref.getInt(PrefUserBirthday).toString();
      _gotData = true;
    });
    print('--> Log checking data: $name - $email - $phone');
  }
}
