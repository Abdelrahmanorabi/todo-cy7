import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/ui/home/Provider/setting_provider.dart';

import '../../theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {

  Widget getSelectedRow(String theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.lightPrimary, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            theme,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: MyTheme.lightPrimary
            ),
          ),
          const Icon(
            Icons.check,
            color: Colors.green,
          )
        ],
      ),
    );
  }

  Widget getUnselectedRow(String theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.lightPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            theme,
            style: Theme.of(context).textTheme.headline5?.copyWith(
              color: MyTheme.lightPrimary
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              settingProvider.changeTheme(ThemeMode.light);
            },
            child: settingProvider.isDark()
                ? getUnselectedRow(AppLocalizations.of(context)!.light)
                : getSelectedRow(AppLocalizations.of(context)!.light),
          ),
          InkWell(
              onTap: () {
                settingProvider.changeTheme(ThemeMode.dark);
              },
              child: settingProvider.isDark()
                  ? getSelectedRow(AppLocalizations.of(context)!.dark)
                  : getUnselectedRow(AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }
}
