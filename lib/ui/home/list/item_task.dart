import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_c7_sun/database/task.dart';
import 'package:todo_c7_sun/ui/home/Provider/setting_provider.dart';
import 'package:todo_c7_sun/ui/theme/my_theme.dart';

import '../../../database/my_database.dart';
import '../../../utils/DialogUtils.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          extentRatio: .2,
          children: [
            SlidableAction(
              onPressed: (buildContext) {
                  deleteTask();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18)),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          decoration: BoxDecoration(
              color: settingProvider.isDark()? MyTheme.lightDark : Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 8,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(widget.task.description,style: TextStyle(
                    color:  settingProvider.isDark()? Colors.white: Colors.black
                  ),)
                ],
              )),
              SizedBox(
                width: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor),
                child: Icon(
                  Icons.check,
                  size: 32,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(){
    DialogUtils.showMessage(context, 'Are you sure,you want to delete this task',
      posActionTitle: 'Yes',
      posAction: ()async{
        DialogUtils.showLoading(context, 'Loading...');
        await MyDataBase.deleteTask(widget.task);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context,'Task deleted successfully',
            posActionTitle: 'OK',
            negActionTitle: 'Undo',
            negAction: (){
              //undo delete   [again insert task in firebase]
            }
        );
      },
      negActionTitle: 'no',

    );

  }
}
