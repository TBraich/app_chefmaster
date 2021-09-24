import 'package:flutter/material.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/screens/webview/webview_screen.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class RecipeVideoInstruction extends StatelessWidget {
  const RecipeVideoInstruction({
    Key key,
    @required this.url,
    @required this.recipe,
  }) : super(key: key);

  final String url;
  final RecipeDetail recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            "Video instruction",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(5),
            ),
            decoration: BoxDecoration(
              // color: kPrimaryLightColor,
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, -15),
              //     blurRadius: 20,
              //     color: Color(0xFFDADADA).withOpacity(0.15),
              //   ),
              // ],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(width: 1.5, color: Colors.grey),
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, WebViewScreen.routeName,
                    arguments: WebViewArguments(
                        url: url))
                ;
              }
              ,
              child: Row(
                children: [
                  Icon(Icons.video_collection_sharp),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    recipe.recipeName,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
