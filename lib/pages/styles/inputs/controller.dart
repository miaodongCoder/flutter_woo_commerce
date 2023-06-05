import 'package:get/get.dart';

class InputsController extends GetxController {
  bool checkVal = true;

  InputsController();

  _initData() {
    update(["inputs"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void onCheckBox(bool val) {
    checkVal = val;
    update(["inputs"]);
  }
}
