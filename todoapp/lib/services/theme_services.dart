// ignore_for_file: non_constant_identifier_names, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';
  // is used to get all the proprty of light or dark from box
  bool _LoadThemeFromBox() {
    return _box.read<bool>(_key) ?? false;
  }

  // is used to save all the proprty of light or dark from box
  _SaveThemeToBox(bool isDarkMode) {
    _box.write(_key, isDarkMode);
  }

  ThemeMode get theme => _LoadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void SwitchTheme() {
    Get.changeThemeMode(_LoadThemeFromBox() ? ThemeMode.dark : ThemeMode.light);
    _SaveThemeToBox(!_LoadThemeFromBox());
  }
}
