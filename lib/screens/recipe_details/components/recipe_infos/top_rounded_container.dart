import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
      padding: EdgeInsets.only(
          top: getProportionateScreenWidth(8),
          bottom: getProportionateScreenWidth(8)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
