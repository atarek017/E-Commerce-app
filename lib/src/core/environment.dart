class Environment {
  static final String baseUrl = 'http://192.168.1.5:4833/';
  static final String userLogin = baseUrl + 'soq/user/login';
  static final String userSignUp = baseUrl + 'soq/user/signup';
  static final String userResendVerifyCode = baseUrl + 'soq/user/resendCode';
  static final String userVerify = baseUrl + 'soq/user/verify';
  static final String userUpdateInfo = baseUrl + 'soq/user/updateUserInfo';
  static final String productDeal = baseUrl + 'soq/products/deal/';
  static final String productType = baseUrl + 'soq/products/type/';
  static final String favouriteProducts = baseUrl + 'soq/products/favourite';
  static final String setFavourite = baseUrl + 'soq/products/setFavourite';

  static final Map<String, String> requestHeader = {
    'Content-Type': 'application/json'
  };
}
