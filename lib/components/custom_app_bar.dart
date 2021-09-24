import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/size_config.dart';

enum BackOpt { NeedBack, NotNeedBack }

class CustomAppBar extends PreferredSize {
  final Widget optsWidget;
  final String label;

  final BackOpt backOpt;

  CustomAppBar({@required this.optsWidget, @required this.label, this.backOpt});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            this.backOpt == null
                ? SizedBox(
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_outlined),
                    ),
                  )
                : SizedBox(
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                  ),
            label != null
                ? Text(
                    label,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  )
                : Spacer(),
            optsWidget != null ? optsWidget : Spacer()
          ],
        ),
      ),
    );
  }
}
