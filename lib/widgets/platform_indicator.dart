import 'package:flutter/material.dart';
import 'package:samip_grubrr/utils/base_extension.dart';

import '../utils/base_colors.dart';

class PlatformIndicator extends StatelessWidget {
  const PlatformIndicator({
    Key? key,
    this.message,
    this.showMessage = true,
  })  : assert(showMessage ? message != null : true,
            'message null when showMessage true'),
        super(key: key);

  final String? message;
  final bool showMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: BaseColors.pink,
          ),
          if (showMessage) ...[
            20.0.toVSB,
            Text(message!),
          ]
        ],
      ),
    );
  }
}
