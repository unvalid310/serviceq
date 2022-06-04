import 'package:serviceq/data/model/response/language_model.dart';
import 'package:serviceq/utill/images.dart';

class AppConstants {
  static const String APP_NAME = 'Haway';
  static const String VERSION = '1.0 (beta)';
  static const API_KEY = 'AIzaSyC4pqaaJrDjDxxm2iU-SIn4bDTmlBOSK70';

  static const String BASE_URL = 'https://serviceq.havaernet.com';

  static const String REGISTER_URI = '/auth/registration';
  static const String LOGIN_URI = '/auth/login';
  static const String FAVORIT_URI = '/favorit';
  static const String LOKASI_URI = '/lokasi';
  static const String SPAREPART_URI = '/sparepart';
  static const String BENGKEL_URI = '/bengkel';
  static const String TIPE_BENGKEL_URI = '/tipebengkel';
  static const String FILTER_URI = '/filter';
  static const String HISTORY_URI = '/histori';
  static const String REKOMENDASI_URI = '/rekomendasi';
  static const String RATING_URI = '/rating';
  static const String ULASAN_URI = '/ulasan';

  // Shared Key
  static const String ID_USER = 'id_user';
  static const String USERNAME = 'username';
  static const String EMAIL = 'email';
  static const String FILTER = 'filter';
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.united_kindom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Indonesian',
        countryCode: 'ID',
        languageCode: 'id'),
  ];
}
