import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/views/webview/webview_screen.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, WebViewScreen.routeName, arguments: WebViewArguments(url: "https://sayingimages.com/wp-content/uploads/nothing-to-see-here-begone-meme.jpg"));
      },
      child: Container(
        // height: 90,
        width: double.infinity,
        margin: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenWidth(5),
        ),
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenWidth(10),
          bottom: getProportionateScreenWidth(50),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: ExactAssetImage('assets/images/knife_banner.png'),
              fit: BoxFit.cover),
        ),
        child: Text.rich(
          TextSpan(
            style: TextStyle(color: Colors.white),
            children: [
              TextSpan(text: "A Sharpest Knife\n"),
              TextSpan(
                text: "Cooking Contest 13/4",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
