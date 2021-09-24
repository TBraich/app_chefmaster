import 'package:flutter/material.dart';
import 'package:chefmaster_app/screens/list_items/list_items_screen.dart';
import 'package:chefmaster_app/utils/enums.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.75,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        // onChanged: (value) => doSearchRecipe(value, context),
        onSubmitted: (value) => doSearchRecipe(value, context),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search recipe...",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }

  doSearchRecipe(String value, BuildContext context) {
    Navigator.pushNamed(context, ListItemsScreen.routeName,
        arguments: ItemsArguments(
            "Search Result",
            ListState.name,
            "?recipeName=$value"));
  }
}
