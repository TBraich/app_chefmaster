class AppUrl {
  static const String liveBaseURL = "https://rsvehyy9xk.execute-api.ap-southeast-1.amazonaws.com/dev2";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/user/login";
  static const String register = baseURL + "/user/register";
  static const String verifyOTP = baseURL + "/user/otp";
  static const String resendOTP = baseURL + "/user/resend_otp";
  static const String getUserInfo = baseURL + "/user/info";
  static const String getRecipes = baseURL + "/recipe/recipes";
  static const String getRecipeDetail = baseURL + "/recipe/detail";
  static const String createRecipe = baseURL + "/recipe/add";
  static const String getUploadUrl = baseURL + "/image/upload";
  static const String getMultipleUploadUrls = baseURL + "/image/multiple-upload";
  static const String updateUserImage = baseURL + "/user/image";
  static const String getCategories = baseURL + "/category/categories";
  static const String setFavoriteRecipe = baseURL + "/recipe/favorite";
  static const String postUpvote = baseURL + "/recipe/post/upvote";
  static const String postComment = baseURL + "/recipe/post/comment";
  static const String postStatus = baseURL + "/recipe/post/status";
}
