import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/views/fail_screen/components/body.dart';

class Fail404Screen extends StatelessWidget {
  static String routeName = "/screen.404";
  const Fail404Screen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PageStorageKey<String>('404'),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
