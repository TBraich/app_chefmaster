import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Align longButtons(String title, Function fun,
    {Color color: kPrimaryColor, Color textColor: Colors.white}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: fun,
      textColor: textColor,
      color: color,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      minWidth: double.infinity,
      height: getProportionateScreenHeight(56),
    ),
  );
}
