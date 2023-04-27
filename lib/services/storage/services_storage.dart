import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesStorage {
  static const username = 'username';

  Future<SharedPreferences> get preference async =>
      await SharedPreferences.getInstance();

  removeAll() async {
    (await preference).clear();
  }

  removePreference({
    required String key,
  }) async {
    (await preference).remove(key);
  }

  setValuePreference({
    required String key,
    dynamic value,
  }) async {
    SharedPreferences localPreference = await preference;
    if (value) {
      switch (value.runtimeType) {
        case Int:
          {
            localPreference.setInt(key, value);
            break;
          }
        case String:
          {
            localPreference.setString(key, value);
            break;
          }
        case double:
          {
            localPreference.setDouble(key, value);
            break;
          }
        case bool:
          {
            localPreference.setBool(key, value);
            break;
          }
        case List<String>:
          {
            localPreference.setStringList(key, value);
            break;
          }
        default:
          {
            debugPrint("ServiceStorage: Value is Not List");
          }
      }
    } else {
      debugPrint("ServiceStorage: Value is Null");
    }
  }

  Future<String> getStringPreferences({
    required String key,
  }) async {
    SharedPreferences localPreferences = await preference;
    var value = localPreferences.getString(key);
    return value ?? "";
  }

  Future<int?> getIntPreferences({
    required String key,
  }) async {
    SharedPreferences localPreferences = await preference;
    return localPreferences.getInt(key);
  }

  Future<double?> getDoublePreferences({
    required String key,
  }) async {
    SharedPreferences localPreferences = await preference;
    return localPreferences.getDouble(key);
  }

  Future<bool?> getBoolPreferences({
    required String key,
  }) async {
    SharedPreferences localPreferences = await preference;
    return localPreferences.getBool(key) ?? false;
  }
}
