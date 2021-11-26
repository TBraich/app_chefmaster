class UploadImage {
  String uploadUrl;
  String downloadUrl;

  UploadImage({this.uploadUrl, this.downloadUrl});

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(
        uploadUrl: json["uploadURL"], downloadUrl: json["downloadURL"]);
  }
}

class UploadMultipleImages {
  final List<UploadImage> response;

  UploadMultipleImages({this.response});

  factory UploadMultipleImages.fromJson(Map<String, dynamic> json) {
    return UploadMultipleImages(
        response: json["response"] != null
            ? json['response']
                .map<UploadImage>((json) => UploadImage.fromJson(json))
                .toList()
            : null);
  }
}
