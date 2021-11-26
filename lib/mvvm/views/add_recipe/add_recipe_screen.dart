import 'package:flutter/material.dart';
import 'package:chefmaster_app/helper/searchdata.dart';
import 'package:chefmaster_app/utils/constants.dart';

import 'components/Body.dart';

class CreateNewRecipe extends StatelessWidget {
  static String routeName = "/mvvm.views.add_recipe";

  const CreateNewRecipe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(20.0, 0.0, 0.0),
          child: Text(
            "Create new recipe",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: SearchData());
        })],
      ),
      body: Body(),
    );
  }
}

