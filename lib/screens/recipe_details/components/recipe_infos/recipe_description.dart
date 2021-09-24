import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class RecipeDescription extends StatefulWidget {
  final RecipeDetail recipe;
  final GestureTapCallback pressOnSeeMore;

  const RecipeDescription({Key key, this.recipe, this.pressOnSeeMore})
      : super(key: key);

  @override
  _RecipeDescriptionState createState() =>
      _RecipeDescriptionState(recipe, pressOnSeeMore);
}

class _RecipeDescriptionState extends State<RecipeDescription> {
  final RecipeDetail recipe;
  final GestureTapCallback pressOnSeeMore;
  bool _isFavorite;
  AuthProvider auth = new AuthProvider();

  _RecipeDescriptionState(this.recipe, this.pressOnSeeMore) {
     _isFavorite = recipe.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            recipe.recipeName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(64),
                ),
                child: Text(
                  recipe.description,
                  maxLines: 3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  doAddFavorite();
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                    width: getProportionateScreenWidth(48),
                    height: getProportionateScreenHeight(36),
                    decoration: BoxDecoration(
                      color: _isFavorite
                          ? Color(0xFFFFE6E6)
                          : Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: _isFavorite
                          ? Color(0xFFFF4848)
                          : Color(0xFFDBDEE4),
                      height: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 18,
                  color: kPrimaryColor,
                ),
                SizedBox(width: 5),
                Text(
                  recipe.creator,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void doAddFavorite() {
    auth.addFavorite(recipe.recipeId);
  }
}
