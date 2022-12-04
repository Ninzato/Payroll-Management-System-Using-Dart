import 'dart:html';

import 'calculation-payroll.dart';

final cal_btn = querySelector("#calculate-btn") as ButtonElement;
void main() {
  Calculation cn = new Calculation();
  void calc() {
    cn.loop_setter_start_end_time();
    querySelector('#Hourstotal')?.text = cn.sumHours().toString();
    querySelector('#salary')?.text = cn.calcSalary().toString();
    querySelector('#finalsalary')?.text = cn.finalSalary().toString();
  }

  cal_btn.onClick.listen((event) {
    calc();
  });
}
