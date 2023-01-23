import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c7_sun/database/task.dart';
import 'package:todo_c7_sun/utils/MyDateUtils.dart';

import '../utils/date.dart';

class MyDataBase {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks')
        .withConverter<Task>(
        fromFirestore: ((snapshot, _) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task, _) => task.toFireStore());
  }

  static Future<void> insertTask(Task task) {
    var docReference = getTasksCollection().doc();
    task.id = docReference.id;
    return docReference.set(task);
  }

  static Future<void> deleteTask(Task task) {
    var taskItem = getTasksCollection().doc(task.id);
    return taskItem.delete();
  }

  // get data once
  static Future<List<Task>> getAllTasks() async {
    var qureySnaphot = await getTasksCollection().get();
    List<Task> taskList = qureySnaphot.docs.map((doc) => doc.data()).toList();

    return taskList;
  }

  static Stream<QuerySnapshot<Task>> listenForRealTimeUpdates(
      DateTime dateTime) {
    Stream<QuerySnapshot<Task>> qureySnaphot = getTasksCollection().where(
        'dateTime', isEqualTo: MyDateUtils
        .dateOnly(dateTime)
        .millisecondsSinceEpoch
    ).snapshots();
    return qureySnaphot;
  }

  static void editIsDone(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDocument = tasksCollection.doc(task.id);
    taskDocument.update({'isDone': task.isDone! ? false : true});
  }


  // function to update task
  static Future<void> editTaskDetails(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDocument = tasksCollection.doc(task.id);
    return taskDocument.update({
      'title': task.title,
      'description': task.description,
      'dateTime': dateOnly(task.dateTime!).millisecondsSinceEpoch,
    });
  }

}

