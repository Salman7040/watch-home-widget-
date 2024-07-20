
import 'package:intl/intl.dart';

class TimeScreen {



  static String getTime(DateTime now ){

  int hour=now.hour;


  if(hour<=12)
    return "${hour}:${now.minute} AM";
  else
    return "${hour-12}:${now.minute} PM ";
  }

  static String getWeek(DateTime now){
    return DateFormat('EEEE').format(now);

  }
  static String getDate(DateTime now){
    return DateFormat('MMM d').format(now);
  }

}