import 'package:get/get.dart';

class BaseSize {
  static double height(num percentage) {
    return (Get.height * percentage) / 100;
  }

  static double width(num percentage) {
    return (Get.width * percentage) / 100;
  }
}
