import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:samip_grubrr/blocs/screen_saver/screen_saver_cubit.dart';
import 'package:samip_grubrr/screens/login_page.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_methods.dart';
import 'package:samip_grubrr/utils/base_strings.dart';
import 'package:samip_grubrr/utils/routes.dart';

class ScreenSaversPage extends StatefulWidget {
  const ScreenSaversPage({Key? key}) : super(key: key);

  @override
  State<ScreenSaversPage> createState() => _ScreenSaversPageState();
}

class _ScreenSaversPageState extends State<ScreenSaversPage> {
  late final ScreenSaverCubit _screenSaverCubit;

  ///note: not updating images as there is only one image

  @override
  void initState() {
    _screenSaverCubit = BlocProvider.of<ScreenSaverCubit>(context)..getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _screenSaverCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      body: BlocBuilder<ScreenSaverCubit, ScreenSaverState>(
        builder: (context, state) {
          if (state is ScreenSaverLoadingInProgress) {
            return const PlatformIndicator(
              message: 'Loading Image.....',
            );
          } else if (state is ScreenSaverCompleted) {
            return InkWell(
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
                  '${BaseApiConstants.apiImageLink}${state.element.imagePath!}',
                  loadingBuilder: (con, c, progress) => customLoadingBuilder(
                    con,
                    c,
                    progress,
                    showMessage: true,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return BaseStrings.screenMastersLoadingFailed.noDataError;
          }
        },
      ),
    );
  }
}
