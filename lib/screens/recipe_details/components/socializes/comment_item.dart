import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatefulWidget {
  final String imageUrl;
  final String userName;
  final String content;
  final String timeComment;

  const CommentItem(
      {Key key, this.imageUrl, this.userName, this.content, this.timeComment})
      : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: GestureDetector(
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(widget.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              // onTap: //TODO
            ),
            flex: 3,
          ),
          Flexible(
            child: SizedBox(width: 18),
            flex: 1,
          ),
          Flexible(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 6, bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.black12,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: getProportionateScreenWidth(16)),
                              maxLines: 1,
                            ),
                            Text(
                              widget.content,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ])),
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      widget.timeComment,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            flex: 15,
          )
        ],
      ),
    );
  }
}
