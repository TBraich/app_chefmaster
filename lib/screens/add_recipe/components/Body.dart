import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/default_button.dart';
import 'package:chefmaster_app/models/RecipeDetail.dart';
import 'package:chefmaster_app/models/UploadImage.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/utils/common_functions.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String recipeId;
  String recipeName;
  String recipeDescription;
  File recipeCoverImage;
  String recipeCoverImageUrl;

  List<String> steps = [""];
  List<RecipeIngredient> ingredients = [
    new RecipeIngredient(gram: 0, ingredientName: "")
  ];
  List<File> recipeImages = [];
  List<String> recipeImagesUrl = [];

  @override
  Widget build(BuildContext context) {
    Future<void> _pullRefresh() async {
      await Future.delayed(Duration(milliseconds: 1000));
    }
    return RefreshIndicator(child: Form(
      key: _formKey,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Recipe Cover Image",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                recipeCover(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Recipe information",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                buildRecipeNameForm(
                    label: "Recipe Name",
                    hint: "Enter your recipe name",
                    function: (newValue) {
                      setState(() {
                        this.recipeName = newValue;
                      });
                    }),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildRecipeDescriptionForm(
                    label: "Recipe Description",
                    hint: "Enter your recipe description",
                    function: (newValue) {
                      setState(() {
                        this.recipeDescription = newValue;
                      });
                    }),
                SizedBox(height: getProportionateScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                buildIngredientsFormField(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "Recipe Step",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                buildStepFormField(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    "More Recipe Images",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                getRecipeImages(),
                SizedBox(height: getProportionateScreenHeight(20)),
                longButtons("Register Recipe", doCreateRecipe),
              ],
            ),
          ),
        ),
      ),
    ), onRefresh: _pullRefresh);
  }

  doCreateRecipe() async {
    var uuid = Uuid();
    final form = _formKey.currentState;
    form.save();

    // get recipeId
    recipeId = uuid.v1();
    print('--> recipeId: ' + recipeId);

    // gen recipe cover image path
    String mainPath =
        "recipe-data/$recipeId/coverImage/cover-$recipeId${p.extension(recipeCoverImage.path)}";
    print('---> mainPath: ' + mainPath);

    // gen recipe images paths
    List<String> imageUrls = [];
    for (int i = 0; i < recipeImages.length; i++) {
      String imageUrl =
          "recipe-data/$recipeId/images/image$i-$recipeId${p.extension(recipeImages[i].path)}";
      imageUrls.add(imageUrl);
      print('---> image$i: $imageUrl');
    }

    // gen body request upload multiple images
    String bodyJsonRequest = getUploadBodyRequest(mainPath, imageUrls);

    // request get upload images
    AuthProvider provider = new AuthProvider();
    final Future<Map<String, dynamic>> messageUploadMultipleUrl =
        provider.postUploadMultipleUrls(bodyJsonRequest);
    // upload recipe images
    uploadRecipeImages(messageUploadMultipleUrl);

    SharedPreferences pref = await SharedPreferences.getInstance();
    // get download images url
    String coverImage;
    List<String> images = [];
    await messageUploadMultipleUrl.then((response) {
      if (response['status']) {
        UploadMultipleImages data = response['data'];
        if (data.response != null) {
          for (int i = 0; i < data.response.length; i++) {
            if (i == 0) {
              coverImage = data.response[i].downloadUrl;
              continue;
            }
            String url = data.response[i].downloadUrl;
            images.add(url);
          }
        } else {
          print('UploadMultipleImages response is null');
        }
      } else {
        print(response);
      }
    });
    // gen createRecipeRequest
    RecipeDetail recipe = getRecipeDetail(recipeId, recipeName,
        recipeDescription, coverImage, images, pref.getString(PrefUserName));

    // create new recipe
    final Future<Map<String, dynamic>> messageCreateRecipe =
        provider.createRecipes(jsonEncode(recipe.toJson()));
    messageCreateRecipe.then((response) {
      if (response['status']) {
        print('create success!');
      } else {
        print(response);
      }
    });

    form.reset();
  }

  Widget recipeCover() {
    return recipeCoverImage == null
        ? Center(
            child: Container(
                margin: EdgeInsets.all(5),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      var _picker = ImagePicker();
                      var pickedFile =
                          await _picker.getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          recipeCoverImage = File(pickedFile.path);
                        });
                      }
                    })))
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.all(5),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(recipeCoverImage.path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  recipeCoverImage = null;
                });
              },
            )
          ]);
  }

  TextFormField buildRecipeNameForm(
      {String label, String hint, function(String newValue)}) {
    return TextFormField(
      onSaved: (newValue) => {function(newValue)},
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: new EdgeInsets.only(left: 25.0, right: 20.0),
      ),
    );
  }

  TextFormField buildRecipeDescriptionForm(
      {String label, String hint, function(String newValue)}) {
    return TextFormField(
      onSaved: (newValue) => {function(newValue)},
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding:
            new EdgeInsets.only(left: 25.0, right: 20.0, top: 24, bottom: 24),
      ),
    );
  }

  Container buildStepFormField() {
    return Container(
      child: Column(
        children: [
          ListView.builder(
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildStepItem(index);
            },
            itemCount: steps.length,
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.grey,
            ),
            onPressed: () {
              steps.add("");
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Column buildStepItem(int index) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: TextFormField(
                  onChanged: (newValue) {
                    steps.removeAt(index);
                    steps.insert(index, newValue);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Step description",
                    labelText: "Step ${index + 1}",
                    contentPadding:
                        new EdgeInsets.only(left: 25.0, right: 20.0),

                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                  ),
                ),
                flex: 7),
            Flexible(
                child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                steps.removeAt(index);
                setState(() {});
              },
            ))
          ],
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Container buildIngredientsFormField() {
    return Container(
      child: Column(
        children: [
          ListView.builder(
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildIngredientItem(index);
            },
            itemCount: ingredients.length,
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.grey,
            ),
            onPressed: () {
              ingredients
                  .add(new RecipeIngredient(gram: 0, ingredientName: ""));
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Column buildIngredientItem(int index) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    ingredients[index].gram =
                        newValue.isNotEmpty ? int.parse(newValue) : 0;
                    setState(() {});
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "0",
                    labelText: "Gram",
                    contentPadding:
                        new EdgeInsets.only(left: 25.0, right: 20.0),
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                  ),
                ),
                flex: 2),
            SizedBox(width: 6),
            Flexible(
                child: TextFormField(
                  onChanged: (newValue) {
                    ingredients[index].ingredientName = newValue;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          new EdgeInsets.only(left: 25.0, right: 20.0),
                      hintText: "Ingredient Name",
                      labelText: "Ingredient ${index + 1}"
                      // If  you are using latest version of flutter then lable text and hint text shown like this
                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                      // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                      ),
                ),
                flex: 5),
            Flexible(
                child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                ingredients.removeAt(index);
                setState(() {});
              },
            ))
          ],
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Container getRecipeImages() {
    return Container(
        width: getProportionateScreenWidth(SizeConfig.screenWidth),
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildImagesItem(index);
          },
          itemCount: recipeImages.length + 1,
        ));
  }

  Widget buildImagesItem(int index) {
    return index == 0
        ? Container(
            margin: EdgeInsets.all(5),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.grey,
                ),
                onPressed: () async {
                  var _picker = ImagePicker();
                  var pickedFile =
                      await _picker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      recipeImages.add(File(pickedFile.path));
                    });
                  }
                }))
        : Stack(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(recipeImages[index - 1].path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      recipeImages.removeAt(index - 1);
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          );
  }

  String getUploadBodyRequest(String mainPath, List<String> imageUrls) {
    List<Map> listBody = [];
    listBody.add({'pathFile': mainPath});
    for (String url in imageUrls) {
      listBody.add({'pathFile': url});
    }

    Map<String, dynamic> jsonBody = {'paths': listBody};

    return jsonEncode(jsonBody);
  }

  // ignore: missing_return
  RecipeImageItem getDownloadRecipeImages(
      Future<Map<String, dynamic>> successfulMessage) {
    successfulMessage.then((response) {
      String coverImage;
      List<String> images = [];
      if (response['status']) {
        UploadMultipleImages data = response['data'];
        if (data.response != null) {
          for (int i = 0; i < data.response.length; i++) {
            if (i == 0) {
              coverImage = data.response[i].downloadUrl;
              continue;
            }
            String url = data.response[i].downloadUrl;
            images.add(url);
          }
          return new RecipeImageItem(coverImageUrl: coverImage, images: images);
        } else {
          print('UploadMultipleImages response is null');
        }
      } else {
        print(response);
      }
    });
  }

  void uploadRecipeImages(Future<Map<String, dynamic>> successfulMessage) {
    successfulMessage.then((response) {
      if (response['status']) {
        UploadMultipleImages data = response['data'];
        if (data.response != null) {
          for (int i = 0; i < data.response.length; i++) {
            print('UPLOAD_URL: ${data.response[i].uploadUrl}');
            var url = Uri.parse(data.response[i].uploadUrl);
            if (i == 0) {
              putFileToS3(url, recipeCoverImage);
              continue;
            }
            putFileToS3(url, recipeImages[i - 1]);
          }
        } else {
          print('UploadMultipleImages response is null');
        }
      } else {
        print(response);
      }
    });
  }

  RecipeDetail getRecipeDetail(
      String recipeId,
      String recipeName,
      String recipeDescription,
      String coverUrl,
      List<String> images,
      String userName) {
    List<RecipeStep> listSteps = List<RecipeStep>.generate(steps.length,
        (index) => RecipeStep(step: index, description: steps[index]));
    List<RecipeImage> listImages = List<RecipeImage>.generate(
        images.length, (index) => RecipeImage(url: images[index]));
    return new RecipeDetail(
        recipeId: recipeId,
        recipeName: recipeName,
        description: recipeDescription,
        coverImageUrl: coverUrl,
        recipeSteps: listSteps,
        detailImageUrl: listImages,
        ingredients: ingredients,
        upvote: 0,
        creator: userName);
  }
}

class RecipeImageItem {
  final String coverImageUrl;
  final List<String> images;

  RecipeImageItem({this.coverImageUrl, this.images});
}
