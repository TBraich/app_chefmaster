import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<bool> putFileToS3(Uri uploadUrl, File file) async {
  var response = await http.put(uploadUrl,
      headers: {"x-amz-acl": "public-read"}, body: file.readAsBytesSync());
  print('---> upload response: ${response.body}');

  if (response.statusCode == 200) {
    print('Success upload image! - url: $uploadUrl');
    return true;
  }

  return false;
}

Map<String, int> timeBetween(DateTime from, DateTime to) {
  Map<String, int> data;
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  (to
      .difference(from)
      .inHours / 24).round();
  if (to
      .difference(from)
      .inDays == 0) {
    if (to
        .difference(from)
        .inHours == 0) {
      if (to
          .difference(from)
          .inMinutes == 0) {
        data = {"seconds": to
            .difference(from)
            .inSeconds};
      } else {
        data = {"minutes": to
            .difference(from)
            .inMinutes};
      }
    } else {
      data = {"hours": to
          .difference(from)
          .inHours};
    }
  } else {
    data = {"days": to
        .difference(from)
        .inDays};
  }
  return data;
}