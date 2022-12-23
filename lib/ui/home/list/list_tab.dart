import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/database/my_database.dart';
import 'package:todo_c7_sun/ui/home/Provider/setting_provider.dart';
import 'package:todo_c7_sun/ui/home/list/item_task.dart';

import '../../../database/task.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  List<Task> allTasks = [];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    // if (allTasks.isEmpty) {
    //   loadTask();
    // }

    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) {
                return;
              }
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            showYears: true,
            monthColor: settingProvider.isDark() ? Colors.white : Colors.black,
            dayColor: settingProvider.isDark() ? Colors.white : Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Color(0xFF333A47),
            selectableDayPredicate: (date) {
              return true;
            },
            locale: 'en_ISO',
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDataBase.listenForRealTimeUpdates(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('something error has occured'),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Task>? tasks = snapshot.data?.docs
                    .map((element) => element.data())
                    .toList();

                return ListView.builder(
                    itemCount: tasks?.length ?? 0,
                    itemBuilder: (_, index) {
                      return TaskItem(task: tasks![index]);
                    });
              }
            },
          ))
        ],
      ),
    );
  }

// void loadTask()async {
//
//  allTasks =  await MyDataBase.getAllTasks();
//   setState(() {});
// }
}
