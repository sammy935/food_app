import 'package:flutter/material.dart';
import 'package:get/get.dart';

String? validateEmpty({required String? name, required String element}) {
  if (name?.isEmpty ?? true) {
    return "$element can't be empty";
  } else {
    return null;
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Loading...")),
      ],
    ),
  );
  Get.dialog(
    alert,
    barrierDismissible: false,
  );
  // showDialog(
  //   barrierDismissible: false,
  //   context: context,
  //   builder: (BuildContext context) {
  //     return alert;
  //   },
  // );
}

showSuccess(String operation) {
  Get.showSnackbar(GetSnackBar(
    title: '$operation was success',
    backgroundColor: Colors.green,
  ));
}

showError(String operation) {
  Get.showSnackbar(GetSnackBar(
    title: '$operation was success',
    backgroundColor: Colors.red,
  ));
}

String? validateEmail({required String? email}) {
  RegExp emailRegExp = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  if (email?.isEmpty ?? true) {
    return 'Email can\'t be empty';
  } else if (!emailRegExp.hasMatch(email!)) {
    return 'Enter a correct email';
  }

  return null;
}

String? validateName({required String? name}) {
  if (name == null) {
    return null;
  }

  if (name.isEmpty) {
    return 'Name can\'t be empty';
  }

  return null;
}

String? validateGender({required String? name}) {
  List genders = ['Female', 'Male', 'All'];
  if (name?.isEmpty ?? true) {
    return 'Gender can\'t be empty';
  } else if (genders.indexWhere(
          (element) => name!.toLowerCase() == element.toLowerCase()) <=
      -1) {
    return 'Please write oen of the following ${genders.join(' ,')}';
  }

  return null;
}

String? validateInstagram({required String? name}) {
  if (name?.isEmpty ?? true) {
    return 'Instagram name can\'t be empty';
  }

  return null;
}

String? validatePassword({required String? password}) {
  if (password == null) {
    return null;
  }

  if (password.isEmpty) {
    return 'Password can\'t be empty';
  } else if (password.length < 5) {
    return 'Enter a password with length at least 5';
  }

  return null;
}

String? validateConfirmPassword({
  required String? password,
  required String? cPassword,
}) {
  if (cPassword?.isEmpty ?? true) {
    return 'Confirm Password can\'t be empty';
  } else if (password != cPassword) {
    return 'Password and confirm password are not same';
  }

  return null;
}
