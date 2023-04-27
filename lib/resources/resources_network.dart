import '../env.dart';

class ResourcesNetwork {
  static const urlProduction = "google.com";
  static const urlDevelopment = "facebook.com";

  String get baseUrl => Env().environmentValue == Environment.production
      ? urlProduction
      : urlDevelopment;
}
