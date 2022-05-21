import 'package:flutter/material.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_strings.dart';
import 'package:samip_grubrr/utils/base_styles.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order screen'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: BaseColors.white,
        child: Text(
          BaseStrings.orderScreenWaring,
          style: BaseStyles.errorText,
        ),
      ),
    );
  }
}
