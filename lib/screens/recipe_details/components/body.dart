import 'package:chefmaster_app/screens/recipe_details/components/recipe_info_tab.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_socializes.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/screens/recipe_details/components/recipe_images.dart';

class Body extends StatefulWidget {
  final RecipeDetail recipe;

  const Body({Key key, this.recipe}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        RecipeImages(recipe: widget.recipe, height: getHeightByScreenPercent(20),),
        Container(
          margin: EdgeInsets.all(10.0),
          // decoration: new BoxDecoration,
          child: new TabBar(
            // give the indicator a decoration (color and border radius)
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: kPrimaryLightColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            controller: _tabController,
            tabs: [
              new Tab(text: 'Recipe'),
              new Tab(text: 'Comments'),
            ],
          ),
        ),
        Container(
          height: getHeightByScreenPercent(60),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                RecipeInfo(recipe: widget.recipe),
                RecipeSocializes(recipe: widget.recipe)
              ],
            )),

      ],
    );
  }
}
