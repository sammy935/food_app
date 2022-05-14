import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/routes.dart';

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
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (route) => false);
        },
        child: SizedBox(
          width: Get.size.width,
          height: Get.size.height,
          child: Image.network(
            url,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                  20.0.toVSB,
                  const Text('Loading Image...')
                ],
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
