import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class NutritionBuild extends StatelessWidget {
  final int value;
  final String title;
  final String subTitle;
  final int color;


  NutritionBuild(this.value, this.title, this.subTitle, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(60),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [
          Flexible(child: Container(
            height: getProportionateScreenHeight(44),
            width: getProportionateScreenWidth(44),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: Color(color),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ), flex: 1,),

          Flexible(child: SizedBox(
            width: 20,
          ), flex: 1,),

          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Flexible(child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ), flex: 1,),

              Flexible(child: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ), flex: 1,)

            ],
          ), flex: 2,)

        ],
      ),
    );
  }

}