// ignore: file_names
enum Environment {
  development,
  staging,
  production,
}

class Env {
  static late Environment _environment;
  set envornment(Environment value) => _environment = value;

  Environment get environmentValue => _environment;
}
