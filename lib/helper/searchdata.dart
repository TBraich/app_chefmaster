import 'package:flutter/material.dart';
import 'package:chefmaster_app/screens/list_items/list_items_screen.dart';
import 'package:chefmaster_app/utils/enums.dart';

class SearchData extends SearchDelegate<String> {
  SearchData();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListItemsScreen(arguments: ItemsArguments(
        "Search Result", ListState.name, "?recipeName=$query"),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("");
  }
}
