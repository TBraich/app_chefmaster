import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefmaster_app/providers/auth.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String picProfile = "";
  String userID = "";
  String uploadUrl = "";

  _ProfilePicState() {
    doConstructor();
  }

  File _image;
  final picker = ImagePicker();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var doGetImage = () async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      showLoadingIndicator(context);
      setState(() {
        hideOpenDialog(context);
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });

      showLoadingIndicator(context);
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: _image.path,
          cropStyle: CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 3.0 / 4.0,
            aspectRatioLockEnabled: true,
          ));
      hideOpenDialog(context);

      if (croppedFile != null) {
        // setState(() {
        //   picProfile = croppedFile.path;
        //   print(picProfile);
        // });
        doUploadImage(croppedFile);
      } else {
        print('No image cropped.');
      }
    };

    return picProfile == ""
        ? SizedBox(
            height: 115,
            width: 115,
          )
        : SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(picProfile),
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: doGetImage,
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Future<void> doConstructor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString(PrefUserID);
      picProfile = prefs.getString(PrefUserImageURL);
      print('-> picProfile: $picProfile');
    });
  }

  Future<void> doUploadImage(File image) async {
    AuthProvider provider = new AuthProvider();
    final Future<Map<String, dynamic>> successfulMessage = provider
        .postUploadUrl("$userID/profile/avatar" + p.extension(image.path));

    successfulMessage.then((response) {
      if (response['status']) {
        print(response['uploadUrl']);
        callToUploadImage(
            response['uploadUrl'], response['downloadUrl'], image, provider);
      } else {
        print(response);
      }
    });
  }

  void callToUploadImage(String uploadUrl, String downloadUrl, File image,
      AuthProvider provider) async {
    try {
      var url = Uri.parse(uploadUrl);
      var response = await http.put(url,
          headers: {"x-amz-acl": "public-read"}, body: image.readAsBytesSync());
      print('response: ' + response.body);
      if (response.statusCode == 200) {
        setState(() {
          picProfile = downloadUrl;
        });
        provider.updateUserImage(userID, downloadUrl);
        print('downloadUrl: ' + downloadUrl);
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
