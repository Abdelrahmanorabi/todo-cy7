import 'package:flutter/material.dart';
import 'package:todo_c7_sun/ui/home/add_task/add_task.dart';
import 'package:todo_c7_sun/ui/home/list/list_tab.dart';
import 'package:todo_c7_sun/ui/home/settings/settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<String> titles = [AppLocalizations.of(context)!.app_title1,AppLocalizations.of(context)!.app_title2];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedTabIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedTabIndex = index;
            });
          },
          currentIndex: selectedTabIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      body: tabs[selectedTabIndex],
    );
  }

  var tabs = [TasksListTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (buildContext) {
          return AddTaskBottomSheet();
        });
  }
}
