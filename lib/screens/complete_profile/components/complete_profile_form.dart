import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/helper/keyboard.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/screens/login_success/login_success_screen.dart';
import 'package:intl/intl.dart';
import 'package:chefmaster_app/components/custom_surfix_icon.dart';
import 'package:chefmaster_app/components/default_button.dart';
import 'package:chefmaster_app/components/form_error.dart';
import 'package:chefmaster_app/screens/otp/otp_screen.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  String email;
  String password;

  CompleteProfileForm(this.email, this.password);

  @override
  _CompleteProfileFormState createState() =>
      _CompleteProfileFormState(this.email, this.password);
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final formatDate = DateFormat("yyyy-MM-dd");
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String email;
  String password;
  String birthDay;

  _CompleteProfileFormState(this.email, this.password);

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = new AuthProvider();

    var doRegister = () {
      showLoadingIndicator(context);
      final form = _formKey.currentState;

      if (form.validate()) {
        form.save();
        KeyboardUtil.hideKeyboard(context);

        final Future<Map<String, dynamic>> successfulMessage = auth.register(
            this.firstName,
            this.lastName,
            this.phoneNumber,
            this.email,
            this.password,
            this.birthDay,
            this.address);

        successfulMessage.then((response) {
          hideOpenDialog(context);
          if (response['status']) {
            Navigator.pushReplacementNamed(context, OtpScreen.routeName, arguments: OtpScreenArguments(phoneNumber));
          } else {
            showAlert(context, response['message'].toString());
          }
        });
      } else {
        hideOpenDialog(context);
        print("form is invalid");
      }
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDateTimeField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          longButtons("Register", doRegister),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  DateTimeField buildDateTimeField() {
    DateTime beforeYear = DateTime(1940);
    DateTime afterYear = DateTime(2021);
    return DateTimeField(
      autofocus: false,
      validator: (value) {
        if (value.isBefore(beforeYear) || value.isAfter(afterYear)) {
          addError(error: kInvalidBirthdayError);
          return "";
        }
        return null;
      },
      format: formatDate,
      onSaved: (newValue) => birthDay = newValue.toString(),
      onChanged: (value) {
        if (!value.isBefore(beforeYear) && !value.isAfter(afterYear)) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        return date;
      },
      decoration: InputDecoration(
        labelText: "Birthday",
        hintText: "Enter the day you're born",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/date.svg"),
      ),
    );
  }
}
