import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samip_grubrr/blocs/auth/auth_bloc.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:samip_grubrr/utils/base_images.dart';
import 'package:samip_grubrr/utils/base_strings.dart';
import 'package:samip_grubrr/widgets/custom_buttons.dart';
import 'package:samip_grubrr/widgets/custom_textfield.dart';

import '../../utils/base_methods.dart';
import '../../utils/routes.dart';
import '../widgets/platform_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();
  FocusNode eFocus = FocusNode();
  FocusNode pFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  // final pManager = PreferenceManager();
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // og('$state in login page');
            if (state is AuthCompleted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.screenSaver,
                (route) => false,
                // arguments: {
                //   BaseApiConstants.url:
                //       state.response.screenSaverMasters!.first.imagePath!
                // },
              );
              // Get.offAllNamed(Routes.screenSaver, arguments: );
            }
          },
          builder: (context, state) {
            if (state is AuthInProgress) {
              return const PlatformIndicator(
                message: 'Authenticating.....',
              );
            } else if (state is AuthCompleted) {
              return const SizedBox.shrink();
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        40.0.toVSB,
                        Center(
                          child: ClipOval(
                            child: FadeInImage(
                              image: const NetworkImage(
                                  'https://picsum.photos/400'),
                              width: 0.40.sw,
                              height: 0.40.sw,
                              placeholder: const AssetImage(BaseImages.shimmer),
                            ),
                          ),
                        ),
                        30.h.toVSB,
                        CustomTextField(
                          controller: eController,
                          label: BaseStrings.email,
                          focus: eFocus,
                          fieldValidator: (s) => validateEmail(email: s),
                          inputAction: TextInputAction.next,
                        ),
                        20.h.toVSB,
                        CustomTextField(
                          controller: pController,
                          label: BaseStrings.password,
                          focus: pFocus,
                          fieldValidator: (s) => validatePassword(password: s),
                        ),
                        90.h.toVSB,
                        CustomElevatedButton(
                          onPressed: () => loginPress(context),
                          title: BaseStrings.login,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          textStyle:
                              Theme.of(context).textTheme.button?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: BaseColors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> loginPress(context) async {
    eFocus.unfocus();
    pFocus.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      authBloc.add(LoginEvent(
          password: pController.text.trim(), email: eController.text.trim()));
    }
  }

  TextStyle get pink14 {
    return TextStyle(
      color: BaseColors.pink,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    );
  }
}
