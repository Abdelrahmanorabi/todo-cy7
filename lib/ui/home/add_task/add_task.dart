import 'package:flutter/material.dart';
import 'package:todo_c7_sun/database/my_database.dart';
import 'package:todo_c7_sun/database/task.dart';
import 'package:todo_c7_sun/utils/DialogUtils.dart';
import 'package:todo_c7_sun/utils/MyDateUtils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.7,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (input) {
                  // validate input and return error message if exist
                  if (input == null || input.trim().isEmpty) {
                    return 'please enter task title';
                  }
                  return null;
                }),
            TextFormField(
              controller: descriptionController,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'description'),
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'please enter description';
                }
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Task Date',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Theme.of(context).primaryColor),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child:
                      Text('${MyDateUtils.formatTaskDate(selectedDateTime)}'),
                )),
            ElevatedButton(
                onPressed: () {
                  insertNewTask();
                  //   Navigator.pop(context);
                },
                child: Text('Sumbit'))
          ],
        ),
      ),
    );


  }

  DateTime selectedDateTime = DateTime.now();

  void insertNewTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDateTime);



    DialogUtils.showLoading(context, 'Loading...');


   // try {

     await  MyDataBase.insertTask(task)
         .timeout( const Duration(seconds: 2),
         onTimeout: () {
           DialogUtils.hideDialog(context);
           DialogUtils.showMessage(context, 'task inserted successfully',
               posActionTitle: 'Ok', posAction: () {
                 Navigator.pop(context);
               }, dismissible: false);

         });


     // DialogUtils.showMessage(context, 'task inserted successfully',
        //  posActionTitle: 'Ok', posAction: () {
       // Navigator.pop(context);
     // }, dismissible: false);
  //  }
    // catch (error) {
    //   DialogUtils.hideDialog(context);
    //   DialogUtils.showMessage(
    //       context,
    //       'Something went wrong.'
    //       'please try again',
    //       posActionTitle: 'Try Again',
    //       posAction: () {
    //         insertNewTask();
    //       },
    //       negActionTitle: 'cancel',
    //       negAction: () {
    //         Navigator.pop(context);
    //       });
    // }
    // .then((value){
    //   // call when future is completed without errors
    //   // show message
    // })
    // .onError((error, stackTrace){
    //
    // });
  }

  void showTaskDatePicker() async {
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    }
    setState(() {
      selectedDateTime = userSelectedDate;
    });
  }

}
