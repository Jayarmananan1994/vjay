class TmdbConfig {
  static String baseUrl;
  static String secureBaseUrl;
  static List backdropSizes;
  static List logoSizes;
  static List posterSizes;
  static List profileSizes;
  static List stillSizes;

  static setTmdbConfig(
      String _baseUrl,
      String _secureBaseUrl,
      List _backdropSizes,
      List _logoSizes,
      List _posterSizes,
      List _profileSizes,
      List _stillSizes) {
    baseUrl = _baseUrl;
    secureBaseUrl = _secureBaseUrl;
    backdropSizes = _backdropSizes;
    logoSizes = _logoSizes;
    posterSizes = _posterSizes;
    profileSizes = _profileSizes;
    stillSizes = _stillSizes;
  }
}
