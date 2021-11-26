import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/models/category.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class CategoryTags extends StatelessWidget {
  final List<Category> data;

  CategoryTags({this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child:  Text("Tags: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          for(Category category in data)
            Container(
              margin: EdgeInsets.only(left: 6, top: 4, bottom: 4),
              padding: EdgeInsets.all(4),
              width: getProportionateScreenWidth(100),
              decoration: BoxDecoration(
                color: Color(0xFFFFA53E),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(category.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
            )
        ],
      ),
    );
  }
}
