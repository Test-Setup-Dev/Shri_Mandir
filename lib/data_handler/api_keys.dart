class BaseUrl {
  static const ENV_DEV = 'Mandir';

  static const ENV_PRO = 'Mandir';

  //TODO: Make sure to use production url when publish the app
  static String env = /*Helper.isTester ? ENV_DEV :*/ ENV_PRO;

  static String get imageBaseUrl => "http://10.36.218.117:8000/";

  static String get baseUrl => "http://192.168.1.7:8000/api/";
}
