import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatTaskDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

 static  DateTime dateOnly(DateTime dateTime){
    return DateTime(dateTime.year,dateTime.month,dateTime.day);
 }
}
