import 'dart:html';
import 'calculation-payroll.dart';

final calBtn = querySelector("#calculate-btn") as ButtonElement;

void main() {
  Calculation cn = new Calculation();
  cn.displayData();

  void calc() {
    cn.loop_setter_start_end_time();
  }

  calBtn.onClick.listen((event) {
    calc();
  });
}
