import 'dart:html';
import 'dart:core';

class Calculation {
  // 6RM per hour.
  final _hourRate = 6, _minuteRate = 0.1, _epf = 0.11;

  Map<int, String> _workingHours = new Map();
  Map<int, String> _start_end_time = new Map();

  //setter for slot of working Hours
  void set_start_end_time(var day, var start, var end) {
    this._start_end_time[day] = start + "," + end;
  }

  //getter for slot of working Hours
  dynamic get_start_end_time() {
    return this._start_end_time;
  }

  //setter for slot of working Hours
  void setWorkingHours(var key, var slotTime) {
    this._workingHours[key] = slotTime;
  }

  //getter for slot of working Hours
  dynamic getWorkingHours() {
    return this._workingHours;
  }

  //Calc the Hours
  int sumHours() {
    var totalHours = 0;
    _workingHours.forEach((k, v) => totalHours = totalHours + int.parse(v));
    return totalHours;
  }

  int calcSalary() {
    return (sumHours() * _hourRate);
  }

  double finalSalary() {
    var d_epf = calcSalary() * _epf;
    return (calcSalary() - d_epf);
  }

  void get_hours_mins_forinput(var id, var start_time, var end_time) {
    start_time = "0000-00-00 " + start_time.toString() + ":00";
    end_time = "0000-00-00 " + end_time.toString() + ":00";
    Duration duration =
        DateTime.parse(end_time).difference(DateTime.parse(start_time)).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    querySelector('#hours-$id')?.text = hours.toString();
    querySelector('#minutes-$id')?.text = minutes.toString();
  }

  void get_hours_mins(var day, var start_time, var end_time) {
    start_time = "0000-00-00 " + start_time.toString() + ":00";
    end_time = "0000-00-00 " + end_time.toString() + ":00";
    Duration duration =
        DateTime.parse(end_time).difference(DateTime.parse(start_time)).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    setWorkingHours(day, hours.toString());
  }

  void loop_setter_start_end_time() {
    for (var i = 1; i <= 22; i++) {
      InputElement timeStart =
          querySelector("#input-time-start-$i") as InputElement;
      InputElement timeEnd =
          querySelector("#input-time-end-$i") as InputElement;
      set_start_end_time(
          i, timeStart.value.toString(), timeEnd.value.toString());
      get_hours_mins(i, timeStart.value.toString(), timeEnd.value.toString());
      get_hours_mins_forinput(
          i, timeStart.value.toString(), timeEnd.value.toString());
    }
  }
}
