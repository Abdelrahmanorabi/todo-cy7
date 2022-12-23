import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier{
  String currentLanguage = 'en';
  ThemeMode currentTheme = ThemeMode.light;

  void changeLanguage(String newLanguage){
    if (newLanguage == currentLanguage) {
      return;
    }
    currentLanguage = newLanguage;
    notifyListeners();
  }



  void changeTheme( ThemeMode newTheme){
    if (newTheme == currentTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }


  bool isDark(){
    return currentTheme == ThemeMode.dark;
  }


}