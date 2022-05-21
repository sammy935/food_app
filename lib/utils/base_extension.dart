import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_styles.dart';

extension StringExtension on String? {
  void get toLog {
    if (kDebugMode) {
      print('LOG::PROJECT::$this');
    }
  }

  void get toErrorLog {
    if (kDebugMode) {
      print('ERROR::PROJECT::$this');
    }
  }

  void get errorSnackBar {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: BaseColors.red,
        title: 'Error',
        message: this,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void get successSnackBar {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: BaseColors.green,
        title: 'Success',
        message: this,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  SnackbarController get alertSnackBar {
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: BaseColors.opal,
        title: 'Alert',
        message: this,
        snackStyle: SnackStyle.GROUNDED,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}

extension NotNullStringExtension on String {
  Widget get noDataError {
    return Center(
      child: Text(
        this,
        textAlign: TextAlign.center,
        style: BaseStyles.errorText,
      ),
    );
  }
}

extension DoubleExtension on double? {
  SizedBox get toVSB {
    return SizedBox(
      height: this,
    );
  }

  SizedBox get toHSB {
    return SizedBox(
      width: this,
    );
  }
}
