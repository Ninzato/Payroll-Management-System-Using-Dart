import 'dart:html';
import 'dart:core';

class Calculation {
  // 6RM per hour.

  final _hourRate = 6, _minuteRate = 0.1, _epf = 0.11;

  Map<int, String> _workingHours = new Map();
  Map<int, String> _workingMinutes = new Map();
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

  //setter for slot of working Minutes
  void setWorkingMinutes(var key, var slotTime) {
    this._workingMinutes[key] = slotTime;
  }

  //getter for slot of working Minutes
  dynamic getWorkingMinutes() {
    return this._workingMinutes;
  }

  //Calc total Hours
  int sumHours() {
    var totalHours = 0;
    _workingHours.forEach((k, v) => totalHours = totalHours + int.parse(v));
    return totalHours;
  }

  //Calc total Minutes
  int sumMinutes() {
    var totalMinutes = 0;
    _workingMinutes
        .forEach((k, v) => totalMinutes = totalMinutes + int.parse(v));
    return totalMinutes;
  }

  double calcSalary() {
    var salHours = sumHours() * _hourRate;
    var salMinutes = sumMinutes() * _minuteRate;
    return (salHours + salMinutes);
  }

  String displaySalary() {
    return (calcSalary().toStringAsFixed(1));
  }

  double calcFinalSalary() {
    var d_epf = calcSalary() * _epf;
    return (calcSalary() - d_epf);
  }

  String displayFinalSalary() {
    return (calcFinalSalary().toStringAsFixed(1));
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
    window.localStorage["hourStorage-$id"] = hours.toString();
    window.localStorage["minutesStorage-$id"] = minutes.toString();
    window.localStorage["start-$id"] = start_time.toString();
    window.localStorage["end-$id"] = end_time.toString();
  }

  void get_hours_mins(var day, var start_time, var end_time) {
    window.localStorage["start-input-$day"] = start_time;
    window.localStorage["end-input-$day"] = end_time;
    start_time = "0000-00-00 " + start_time.toString() + ":00";
    end_time = "0000-00-00 " + end_time.toString() + ":00";
    Duration duration =
        DateTime.parse(end_time).difference(DateTime.parse(start_time)).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    setWorkingHours(day, hours.toString());
    setWorkingMinutes(day, minutes.toString());
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

      querySelector('#Hourstotal')?.text = sumHours().toString();
      querySelector('#Minutestotal')?.text = sumMinutes().toString();
      querySelector('#salary')?.text = "RM " + displaySalary().toString();
      querySelector('#finalsalary')?.text =
          "RM " + displayFinalSalary().toString();
      window.localStorage["totalHours"] = sumHours().toString();
      window.localStorage["totalMinutes"] = sumMinutes().toString();
      window.localStorage["salary"] = "RM " + displaySalary().toString();
      window.localStorage["finalSalary"] =
          "RM " + displayFinalSalary().toString();
    }
  }

  void displayData() {
    for (var i = 1; i <= 22; i++) {
      querySelector("#hours-$i")?.text = window.localStorage["hourStorage-$i"];
      querySelector("#minutes-$i")?.text =
          window.localStorage["minutesStorage-$i"];

      InputElement start_input =
          querySelector("#input-time-start-$i") as InputElement;
      InputElement end_input =
          querySelector("#input-time-end-$i") as InputElement;

      start_input.value = window.localStorage["start-input-$i"];
      end_input.value = window.localStorage["end-input-$i"];
    }
    querySelector('#Hourstotal')?.text = window.localStorage["totalHours"];
    querySelector('#Minutestotal')?.text = window.localStorage["totalMinutes"];
    querySelector('#salary')?.text = window.localStorage["salary"];
    querySelector('#finalsalary')?.text = window.localStorage["finalSalary"];
  }
}
