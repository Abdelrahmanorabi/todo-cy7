import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/ui/theme/my_theme.dart';

import '../Provider/setting_provider.dart';

class LanguageBottomSheet extends StatefulWidget {

  
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {


  Widget getSelectedRow(String language) {
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
            language,
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

  Widget getUnselectedRow(String language) {
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
            language,
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
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 30),

      child: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //   margin:const EdgeInsets.only(bottom: 20),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: MyTheme.lightPrimary,width: 1),
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.grey.shade400
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('English',style: Theme.of(context).textTheme.headline5,),
          //       Icon(Icons.check,color: Colors.green,)
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //   margin:const EdgeInsets.only(bottom: 20),
          //   decoration: BoxDecoration(
          //       border: Border.all(color: MyTheme.lightPrimary,width: 1),
          //       borderRadius: BorderRadius.circular(10),
          //    ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('العربية',style: Theme.of(context).textTheme.headline5,),
          //
          //     ],
          //   ),
          // )
          
          InkWell(
            onTap: (){
              settingProvider.changeLanguage('en');
            },
            child: settingProvider.currentLanguage == 'en'?
            getSelectedRow('English'):
            getUnselectedRow('English'),
          ),
          InkWell(
            onTap: (){
              settingProvider.changeLanguage('ar');
            },
            child: settingProvider.currentLanguage == 'ar'?
            getSelectedRow('العربية'):
            getUnselectedRow('العربية'),
          ),
        ],
      ),
    );
  }
}
