import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c7_sun/database/task.dart';
import 'package:todo_c7_sun/utils/MyDateUtils.dart';

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

  static Future<void> deleteTask(Task task){
    var taskItem = getTasksCollection().doc(task.id);
    return taskItem.delete();
  }

  // get data once
  static Future<List<Task>> getAllTasks() async {
    var qureySnaphot = await getTasksCollection().get();
    List<Task> taskList = qureySnaphot.docs.map((doc) => doc.data()).toList();

    return taskList;
  }

  static Stream<QuerySnapshot<Task>> listenForRealTimeUpdates(DateTime dateTime) {
    Stream<QuerySnapshot<Task>> qureySnaphot =   getTasksCollection().where(
      'dateTime',isEqualTo:MyDateUtils.dateOnly(dateTime).millisecondsSinceEpoch
    ).snapshots();
     return qureySnaphot;
  }


}

