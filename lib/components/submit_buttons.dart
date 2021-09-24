import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/constants.dart';

class SubmitButtons extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;

  SubmitButtons({@required this.widget1, @required this.widget2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 1,
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
              child: widget1
            )),
        Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 6),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kOppositePrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: widget2
            )),
      ],
    );
  }
}
