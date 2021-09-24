import 'package:flutter/cupertino.dart';
import 'package:chefmaster_app/components/default_button.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "SORRY...",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Service is not available now...\nPlease come back later!",
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          "assets/images/404.png",
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
        Spacer(flex: 3),
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30,bottom: 80),
          child: DefaultButton(
            text: "RETURN",
            press: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
