import 'package:intl/intl.dart';

String getDateTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);

  String formattedDate =
      DateFormat('d/M/yyyy hh:mm:ss a').format(dateTime.toLocal());

  return formattedDate;
}

String getDateTime12Hour(String dateString) {
  DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateFormat outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss a');

  DateTime dateTime = inputFormat.parse(dateString);
  String formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}

String ISOtoNormal(String dateString) {
  int timestamp = int.parse(dateString);

  // Convert the timestamp to a DateTime object
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

  // Format the DateTime object to ISO 8601 format
  String formattedDate =
      DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime) + 'Z';

  // DateTime dateTime = DateTime.parse(dateString);
  //
  // String formattedDate =
  //     DateFormat('d/M/yyyy hh:mm:ss a').format(dateTime.toLocal());

  return formattedDate;
}

String getTimeFromDateShort(String date) {
  DateTime dateTime;
  try {
    dateTime = DateTime.parse(date).toLocal();
    DateTime now = DateTime.now();
    final diff = dateTime.difference(now);
    if (diff.isNegative) {
      return "Ended";
    }
    var time = diff.toString().split(":");

    String formattedTime = "";
    int count = 0;
    for (var i = time.length - 1; i >= 0; i--) {
      if (count == 0) {
        int seconds = double.parse(time[i]).floor();
        formattedTime = "${seconds}s $formattedTime";
        count++;
      } else if (count == 1) {
        formattedTime = "${time[i]}m $formattedTime";
        count++;
      } else if (count == 2) {
        if (int.parse(time[i]) > 24) {
          int d = (int.parse(time[i]) / 24).floor();
          int h = int.parse(time[i]) % 24;
          formattedTime = "${d}d ${h}h $formattedTime";
        } else {
          formattedTime = "${time[i]}h $formattedTime";
        }
        count++;
      }
    }
    // print("object $formattedTime");
    return formattedTime;
  } catch (e) {
    return date;
  }
}

String getDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('MMMM d, y').format(dateTime);
  return (formattedDate);
}
