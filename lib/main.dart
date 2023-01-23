import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/firebase_options.dart';
import 'package:todo_c7_sun/ui/home/Provider/setting_provider.dart';
import 'package:todo_c7_sun/ui/home/home_screen.dart';
import 'package:todo_c7_sun/ui/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return SettingProvider();
      },
      child: MyApplication()),);
}


class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {HomeScreen.routeName: (_) => HomeScreen()},
      initialRoute: HomeScreen.routeName,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale:Locale(settingProvider.currentLanguage) ,

      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      themeMode:settingProvider.currentTheme ,
    );
  }
}
