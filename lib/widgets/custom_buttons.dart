import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samip_grubrr/utils/base_colors.dart';
import 'package:samip_grubrr/utils/base_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      this.title = '',
      this.padding,
      this.textStyle})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        primary: BaseColors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    Key? key,
    required this.callback,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    required this.padding,
  }) : super(key: key);

  final VoidCallback callback;
  final String name;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          primary: textColor,
          backgroundColor: backgroundColor,
          padding: padding,
          textStyle: BaseStyles.buttonTextStyle,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(100, 40),
        ),
        onPressed: callback,
        child: Text(name));
  }
}
