// ignore_for_file: unnecessary_late

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // 工厂构造函数 + 空安全 + 箭头函数:使用late 之后:
  Storage._internal();
  factory Storage() => _instance;
  // 被标记为 late 的变量 _instance 的初始化操作将会延迟到字段首次被访问时执行,
  // 而不是在类加载时就初始化.这样,Dart 语言特有的单例模式的实现方式就这么产生了~
  static late final Storage _instance = Storage._internal();
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 直接保存JSON数据:
  Future<bool> setJson(String key, Object value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  List<String> getList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
