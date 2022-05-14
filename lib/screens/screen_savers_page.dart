import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';
import 'package:samip_grubrr/utils/base_colors.dart';

class ScreenSaversPage extends StatelessWidget {
  const ScreenSaversPage({Key? key, required this.url}) : super(key: key);

  final String url;
  //todo update image
  ///note: not updating images as there is only one image
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> args = Get.arguments;
    // String? url = BaseApiConstants.apiImageLink + args[BaseApiConstants.url];
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: SizedBox(
        width: Get.size.width,
        height: Get.size.height,
        child: Image.network(
          url,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
