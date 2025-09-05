import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mandir/utils/helper.dart';

class Const {
  static final RxInt notificationCount = 0.obs;

  static const String testNumber = '911234567890';
  static const String testName = 'AR';
  static const String testEmail = 'testsetup.dev@gmail.com';
  static const String testAddress = 'ISBT Dehradun';
  static const String testPassword = '123456';

  static const String token = 'cdfd2357cd';

  static List<String> testerIds = [];
  // static final Rx<Config> config = Config().obs;
  static double loaderSize = 80;

  static String timeZone = 'UTC';
  static String packageName = '';
  static String versionCode = '0';
  static String versionName = '0';

  static final RxString name = 'AJAY RAWAT'.obs;
  static final RxString email = 'ajay@gmail.com'.obs;
  static final RxString profilePic = ''.obs;

  static const double webWidth = 420.0;

  // static final RxString authType = ''.obs;
  static AppLifecycleState? lifecycleState = AppLifecycleState.resumed;

  static final Set<String> skus = <String>{};
  // static final Rx<PurchaseDetails> subscription = PurchaseDetails(
  //         productID: '',
  //         purchaseID: '',
  //         verificationData: PurchaseVerificationData(localVerificationData: '', serverVerificationData: '', source: ''),
  //         transactionDate: '',
  //         status: PurchaseStatus.error)
  //     .obs;
  // static Map<String, FeatureStatus> featuresStatus = <String, FeatureStatus>{};
  // static Map<String, String> currencySymbols = {'USD': '\$', 'INR': 'Rs'};
  //
  // static Result trialPlan = Result();
  //
  // static final RxBool isSubscriptionAvailable = false.obs;
  // static final Rx<bool> onTrial = false.obs;
  // static List<String> allowedApis = [];
  //
  // static const List<String> scheduleOptions = ['Send Now', 'Make Schedule'];
  // static const List<String> uploadTypes = ['List', 'File'];
  //
  // static void reset() {
  //   Const.name.value = '';
  //   Const.email.value = '';
  //   Const.profilePic.value = '';
  //   Const.notificationCount.value = 0;
  //   subscription.value = PurchaseDetails(
  //       productID: '',
  //       purchaseID: '',
  //       verificationData: PurchaseVerificationData(localVerificationData: '', serverVerificationData: '', source: ''),
  //       transactionDate: '',
  //       status: PurchaseStatus.error);
  //   Const.trialPlan = Result();
  //
  //   Const.isSubscriptionAvailable.value = false;
  //   Const.onTrial.value = false;
  // }

  static final List<String> supportedImageType = [
    //IMAGE
    'image/jpeg',
    'image/jpg',
    'image/gif',
    'image/png',
  ];

  static final List<String> supportedAudioType = [
    //AUDIO
    'audio/basic',
    'audio/L24',
    'audio/mp4',
    'audio/mpeg',
    'audio/ogg',
    'audio/3gpp',
    'audio/3gpp2',
    'audio/ac3',
    'audio/webm',
    'audio/amr-nb',
    'audio/amr',
    'audio/mp3', //Extra
  ];

  static final List<String> supportedVideoType = [
    //VIDEO
    'video/mpeg',
    'video/mp4',
    'video/quicktime',
    'video/webm',
    'video/3gpp',
    'video/3gpp2',
    'video/3gpp-tt',
    'video/H261',
    'video/H263',
    'video/H263-1998',
    'video/H263-2000',
    'video/H264',
  ];

  static List<String> get allSupportedMimeType => [
        ...supportedImageType,
        ...supportedAudioType,
        ...supportedVideoType,
      ];

  static List<String> get allSupportableExtensions => allSupportedMimeType.map((e) => e.split('/').last).toList();

  static List<String> countryCodes = [
    '93',
    '355',
    '213',
    '1684',
    '376',
    '244',
    '1264',
    '672',
    '1268',
    '54',
    '374',
    '297',
    '61',
    '43',
    '994',
    '1242',
    '973',
    '880',
    '1246',
    '375',
    '32',
    '501',
    '229',
    '1441',
    '975',
    '591',
    '387',
    '267',
    '55',
    '246',
    '1284',
    '673',
    '359',
    '226',
    '257',
    '855',
    '237',
    '1',
    '238',
    '1345',
    '236',
    '235',
    '56',
    '86',
    '61',
    '61',
    '57',
    '269',
    '682',
    '506',
    '385',
    '53',
    '599',
    '357',
    '420',
    '243',
    '45',
    '253',
    '1767',
    '1809',
    '1829',
    '1849',
    '670',
    '593',
    '20',
    '503',
    '240',
    '291',
    '372',
    '251',
    '500',
    '298',
    '679',
    '358',
    '33',
    '689',
    '241',
    '220',
    '995',
    '49',
    '233',
    '350',
    '30',
    '299',
    '1473',
    '1671',
    '502',
    '441481',
    '224',
    '245',
    '592',
    '509',
    '504',
    '852',
    '36',
    '354',
    '91',
    '62',
    '98',
    '964',
    '353',
    '441624',
    '972',
    '39',
    '225',
    '1876',
    '81',
    '441534',
    '962',
    '7',
    '254',
    '686',
    '383',
    '965',
    '996',
    '856',
    '371',
    '961',
    '266',
    '231',
    '218',
    '423',
    '370',
    '352',
    '853',
    '389',
    '261',
    '265',
    '60',
    '960',
    '223',
    '356',
    '692',
    '222',
    '230',
    '262',
    '52',
    '691',
    '373',
    '377',
    '976',
    '382',
    '1664',
    '212',
    '258',
    '95',
    '264',
    '674',
    '977',
    '31',
    '599',
    '687',
    '64',
    '505',
    '227',
    '234',
    '683',
    '850',
    '1670',
    '47',
    '968',
    '92',
    '680',
    '970',
    '507',
    '675',
    '595',
    '51',
    '63',
    '64',
    '48',
    '351',
    '1787',
    '1939',
    '974',
    '242',
    '262',
    '40',
    '7',
    '250',
    '590',
    '290',
    '1869',
    '1758',
    '590',
    '508',
    '1784',
    '685',
    '378',
    '239',
    '966',
    '221',
    '381',
    '248',
    '232',
    '65',
    '1721',
    '421',
    '386',
    '677',
    '252',
    '27',
    '82',
    '211',
    '34',
    '94',
    '249',
    '597',
    '47',
    '268',
    '46',
    '41',
    '963',
    '886',
    '992',
    '255',
    '66',
    '228',
    '690',
    '676',
    '1868',
    '216',
    '90',
    '993',
    '1649',
    '688',
    '1340',
    '256',
    '380',
    '971',
    '44',
    '1',
    '598',
    '998',
    '678',
    '379',
    '58',
    '84',
    '681',
    '212',
    '967',
    '260',
    '263',
  ];

  static List<Map<String, String>> countryData = [
    {'code': '93', 'flag': '🇦🇫'}, // Afghanistan
    {'code': '355', 'flag': '🇦🇱'}, // Albania
    {'code': '213', 'flag': '🇩🇿'}, // Algeria
    {'code': '1684', 'flag': '🇦🇸'}, // American Samoa
    {'code': '376', 'flag': '🇦🇩'}, // Andorra
    {'code': '244', 'flag': '🇦🇴'}, // Angola
    {'code': '1264', 'flag': '🇦🇮'}, // Anguilla
    {'code': '672', 'flag': '🇦🇶'}, // Antarctica
    {'code': '1268', 'flag': '🇦🇬'}, // Antigua and Barbuda
    {'code': '54', 'flag': '🇦🇷'}, // Argentina
    {'code': '374', 'flag': '🇦🇲'}, // Armenia
    {'code': '297', 'flag': '🇦🇼'}, // Aruba
    {'code': '61', 'flag': '🇦🇺'}, // Australia
    {'code': '43', 'flag': '🇦🇹'}, // Austria
    {'code': '994', 'flag': '🇦🇿'}, // Azerbaijan
    {'code': '1242', 'flag': '🇧🇸'}, // Bahamas
    {'code': '973', 'flag': '🇧🇭'}, // Bahrain
    {'code': '880', 'flag': '🇧🇩'}, // Bangladesh
    {'code': '1246', 'flag': '🇧🇧'}, // Barbados
    {'code': '375', 'flag': '🇧🇾'}, // Belarus
    {'code': '32', 'flag': '🇧🇪'}, // Belgium
    {'code': '501', 'flag': '🇧🇿'}, // Belize
    {'code': '229', 'flag': '🇧🇯'}, // Benin
    {'code': '1441', 'flag': '🇧🇲'}, // Bermuda
    {'code': '975', 'flag': '🇧🇹'}, // Bhutan
    {'code': '591', 'flag': '🇧🇴'}, // Bolivia
    {'code': '387', 'flag': '🇧🇦'}, // Bosnia and Herzegovina
    {'code': '267', 'flag': '🇧🇼'}, // Botswana
    {'code': '55', 'flag': '🇧🇷'}, // Brazil
    {'code': '673', 'flag': '🇧🇳'}, // Brunei
    {'code': '359', 'flag': '🇧🇬'}, // Bulgaria
    {'code': '226', 'flag': '🇧🇫'}, // Burkina Faso
    {'code': '257', 'flag': '🇧🇮'}, // Burundi
    {'code': '855', 'flag': '🇰🇭'}, // Cambodia
    {'code': '237', 'flag': '🇨🇲'}, // Cameroon
    {'code': '1', 'flag': '🇨🇦'}, // Canada
    {'code': '238', 'flag': '🇨🇻'}, // Cape Verde
    {'code': '1345', 'flag': '🇰🇾'}, // Cayman Islands
    {'code': '236', 'flag': '🇨🇫'}, // Central African Republic
    {'code': '56', 'flag': '🇨🇱'}, // Chile
    {'code': '86', 'flag': '🇨🇳'}, // China
    {'code': '57', 'flag': '🇨🇴'}, // Colombia
    {'code': '269', 'flag': '🇰🇲'}, // Comoros
    {'code': '506', 'flag': '🇨🇷'}, // Costa Rica
    {'code': '385', 'flag': '🇭🇷'}, // Croatia
    {'code': '53', 'flag': '🇨🇺'}, // Cuba
    {'code': '357', 'flag': '🇨🇾'}, // Cyprus
    {'code': '420', 'flag': '🇨🇿'}, // Czech Republic
    {'code': '243', 'flag': '🇨🇩'}, // DR Congo
    {'code': '45', 'flag': '🇩🇰'}, // Denmark
    {'code': '253', 'flag': '🇩🇯'}, // Djibouti
    {'code': '1767', 'flag': '🇩🇲'}, // Dominica
    {'code': '1809', 'flag': '🇩🇴'}, // Dominican Republic
    {'code': '593', 'flag': '🇪🇨'}, // Ecuador
    {'code': '20', 'flag': '🇪🇬'}, // Egypt
    {'code': '503', 'flag': '🇸🇻'}, // El Salvador
    {'code': '291', 'flag': '🇪🇷'}, // Eritrea
    {'code': '372', 'flag': '🇪🇪'}, // Estonia
    {'code': '251', 'flag': '🇪🇹'}, // Ethiopia
    {'code': '33', 'flag': '🇫🇷'}, // France
    {'code': '995', 'flag': '🇬🇪'}, // Georgia
    {'code': '49', 'flag': '🇩🇪'}, // Germany
    {'code': '233', 'flag': '🇬🇭'}, // Ghana
    {'code': '30', 'flag': '🇬🇷'}, // Greece
    {'code': '502', 'flag': '🇬🇹'}, // Guatemala
    {'code': '224', 'flag': '🇬🇳'}, // Guinea
    {'code': '509', 'flag': '🇭🇹'}, // Haiti
    {'code': '504', 'flag': '🇭🇳'}, // Honduras
    {'code': '852', 'flag': '🇭🇰'}, // Hong Kong
    {'code': '91', 'flag': '🇮🇳'}, // India
    {'code': '62', 'flag': '🇮🇩'}, // Indonesia
    {'code': '98', 'flag': '🇮🇷'}, // Iran
    {'code': '353', 'flag': '🇮🇪'}, // Ireland
    {'code': '972', 'flag': '🇮🇱'}, // Israel
    {'code': '39', 'flag': '🇮🇹'}, // Italy
    {'code': '81', 'flag': '🇯🇵'}, // Japan
    {'code': '962', 'flag': '🇯🇴'}, // Jordan
    {'code': '7', 'flag': '🇷🇺'}, // Russia
    {'code': '966', 'flag': '🇸🇦'}, // Saudi Arabia
    {'code': '27', 'flag': '🇿🇦'}, // South Africa
    {'code': '82', 'flag': '🇰🇷'}, // South Korea
    {'code': '44', 'flag': '🇬🇧'}, // UK
    {'code': '1', 'flag': '🇺🇸'}, // USA
    {'code': '380', 'flag': '🇺🇦'}, // Ukraine
    {'code': '971', 'flag': '🇦🇪'}, // United Arab Emirates
    {'code': '998', 'flag': '🇺🇿'}, // Uzbekistan
    {'code': '84', 'flag': '🇻🇳'}, // Vietnam
    {'code': '263', 'flag': '🇿🇼'}, // Zimbabwe
  ];

}

class PlatformType {
  static String platformType = '';

  static get isAndroid => platformType == 'android';

  static final bool isLinux = platformType == 'linux';

  static final bool isMacOS = platformType == 'macos';

  static final bool isWindows = platformType == 'windows';

  static final bool isIOS = platformType == 'ios';

  static final bool isFuchsia = platformType == 'fuchsia';

  static final bool isWeb = platformType == 'web';

  static final bool isMobile = isAndroid || isIOS;

  static final RxBool isWebMobileView = (100.w <= 411 || isAndroid || isIOS).obs;
}

class Status {
  static const String NORMAL = 'NORMAL';
  static const String PROGRESS = 'PROGRESS';
  static const String EMPTY = 'EMPTY';
  static const String ERROR = 'ERROR';
  static const String COMPLETED = 'COMPLETED';
}

class FileUploadType {
  static const PROFILE_IMG = 'PROFILE_IMG';
  static const FILE = 'FILE';
  static const SMS_MEDIA = 'SMS_MEDIA';
  static const LOGS = 'LOGS';
}

class SupportedMimeType {
  //IMAGE
  static const IMAGE_JPEG = "image/jpeg";
  static const IMAGE_JPG = "image/jpg";
  static const IMAGE_GIF = "image/gif";
  static const IMAGE_PNG = "image/png";

  //AUDIO
  static const AUDIO_BASIC = "audio/basic";
  static const AUDIO_L24 = "audio/L24";
  static const AUDIO_MP4 = "audio/mp4";
  static const AUDIO_MPEG = "audio/mpeg";
  static const AUDIO_OGG = "audio/ogg";
  static const AUDIO_3GPP = "audio/3gpp";
  static const AUDIO_3GPP2 = "audio/3gpp2";
  static const AUDIO_AC3 = "audio/ac3";
  static const AUDIO_WEBM = "audio/webm";
  static const AUDIO_AMR_NB = "audio/amr-nb";
  static const AUDIO_AMR = "audio/amr";

  //VIDEO
  static const VIDEO_MPEG = "video/mpeg";
  static const VIDEO_MP4 = "video/mp4";
  static const VIDEO_QUICKTIME = "video/quicktime";
  static const VIDEO_WEBM = "video/webm";
  static const VIDEO_3GPP = "video/3gpp";
  static const VIDEO_3GPP2 = "video/3gpp2";
  static const VIDEO_3GPP_TT = "video/3gpp-tt";
  static const VIDEO_H261 = "video/H261";
  static const VIDEO_H263 = "video/H263";
  static const VIDEO_H263_1998 = "video/H263-1998";
  static const VIDEO_H263_2000 = "video/H263-2000";
  static const VIDEO_H264 = "video/H264";
}

class FeatureStatus {
  String _type;
  bool _accessibleInTrial;
  bool _hasAccess;
  String _message;

  FeatureStatus(this._type, this._accessibleInTrial, this._hasAccess, this._message);

  bool get isPremium => _type == 'premium';

  bool get isAccessibleInTrial => _accessibleInTrial;

  bool get hasAccess => _hasAccess;

  String get message => _message;

  @override
  String toString() {
    return '{_type: $_type, _accessibleInTrial: $_accessibleInTrial, _hasAccess: $_hasAccess, _message: $_message}';
  }
}

class ServiceType {
  static const TWILIO = 'Twilio';
  static const PLIVO = 'Plivo';
}
