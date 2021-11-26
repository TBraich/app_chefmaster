import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/loading_indicator.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/mvvm/views/recipe_details/details_screen.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final double aspectRatio;

  Body({this.aspectRatio = 1.05});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthProvider auth = new AuthProvider();
  List<RecipeDetail> recipes = [];
  bool loadedStatus = false;

  _BodyState() {
    doGetListRecipes();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _pullRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
      doGetListRecipes();
      setState(() {});
    }
    return RefreshIndicator(child: FutureBuilder(
        future: doNothing(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              loadedStatus == true) {
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, position) {
                return Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                  height: 100,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(
                          context, RecipeDetailsScreen.routeName,
                          arguments: RecipeDetailsArguments(
                              recipeID: recipes[position].recipeId))
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AspectRatio(
                          aspectRatio: widget.aspectRatio,
                          child: Container(
                            decoration: BoxDecoration(
                              color: kSecondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      recipes[position].coverImageUrl),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipes[position].recipeName,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: getProportionateScreenWidth(18)),
                                maxLines: 1,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  "${recipes[position].creator}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Upvote: ",
                                      style: TextStyle(
                                        fontSize:
                                        getProportionateScreenWidth(14),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      recipes[position].upvote.toString(),
                                      style: TextStyle(
                                        fontSize:
                                        getProportionateScreenWidth(14),
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          flex: 5,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: (){
                                setState(() {
                                  auth.addFavorite(recipes[position].recipeId);
                                  doGetListRecipes();
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: LoadingIndicator(),
            );
          }
        }), onRefresh: _pullRefresh);
  }

  Future<void> doNothing() async {}

  Future<void> doGetListRecipes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final Future<Map<String, dynamic>> successfulMessage =
         auth.getRecipes("?userID=${sharedPreferences.getString(PrefUserID)}", state: ListState.favorite);

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          recipes = response['recipes'];
          loadedStatus = true;
        });
        print('Success loading data!');
        // return;
      } else {
        print(response);
        // return;
      }
    });
  }
}
