import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/custom_bottom_nav_bar.dart';
import 'package:chefmaster_app/helper/searchdata.dart';
import 'package:chefmaster_app/mvvm/models/category.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeArguments itemsArgs =
    ModalRoute.of(context).settings.arguments as HomeArguments;
    return Scaffold(
      key: PageStorageKey<String>('home'),
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: Text(
            "chefmaster",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: SearchData());
        })],
      ),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

class HomeArguments {
  final List<RecipeDetail> popRecipes;
  final List<Category> categories;

  HomeArguments({@required this.popRecipes,@required this.categories});

}