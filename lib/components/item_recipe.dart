import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/mvvm/views/recipe_details/details_screen.dart';

import '../utils/constants.dart';
import '../utils/size_config.dart';

class ItemPopularRecipe extends StatelessWidget {
  const ItemPopularRecipe({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.recipe,
  }) : super(key: key);

  final double width, aspectRetio;
  final RecipeDetail recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, RecipeDetailsScreen.routeName,
                arguments: RecipeDetailsArguments(recipeID: recipe.recipeId))
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: aspectRetio,
                child: Container(
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(recipe.coverImageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                recipe.recipeName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(14)),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      width: 110,
                      child: Text(
                        "${recipe.creator}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    flex: 3,
                  ),
                  Flexible(child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      // padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(32),
                      width: getProportionateScreenWidth(32),
                      decoration: BoxDecoration(
                        color: true
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      // child: SvgPicture.asset(
                      //   "assets/icons/Heart Icon_2.svg",
                      //   color: true ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      // ),
                      child: Center(
                          child: Text(
                            "${recipe.upvote}",
                            style:
                            TextStyle(color: Color(0xFFFF4848), fontSize: 14),
                          )),
                    ),
                  ), flex: 1,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
