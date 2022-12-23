import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/ui/home/Provider/setting_provider.dart';
import 'package:todo_c7_sun/ui/home/settings/theme_bottom_sheet.dart';
import 'package:todo_c7_sun/ui/theme/my_theme.dart';

import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: settingProvider.isDark() ? Colors.white : Colors.black),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: MyTheme.lightPrimary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingProvider.currentLanguage == 'en'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: MyTheme.lightPrimary),
                ),
                IconButton(
                    onPressed: () {
                      showLanguageBottomSheet();
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyTheme.lightPrimary,
                    ))
              ],
            ),
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: settingProvider.isDark() ? Colors.white : Colors.black),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: MyTheme.lightPrimary)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingProvider.isDark()
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: MyTheme.lightPrimary),
                ),
                IconButton(
                    onPressed: () {
                      showThemeBottomSheet();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyTheme.lightPrimary,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
