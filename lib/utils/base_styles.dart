import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samip_grubrr/utils/base_colors.dart';

class BaseStyles {
  static TextStyle welcomeText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: BaseColors.white,
  );

  static TextStyle personName = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    color: BaseColors.white,
  );

  static TextStyle unLimitedText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
    color: BaseColors.white,
  );

  static TextStyle elementName = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
    color: BaseColors.black,
  );

  static TextStyle descriptionText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: BaseColors.pink,
  );

  static TextStyle searchText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: const Color(0xFF898989),
  );

  static TextStyle elementTitleText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
    color: BaseColors.black,
  );

  static TextStyle discountText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: BaseColors.pink,
  );

  static TextStyle radioListTileText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
    color: BaseColors.black,
  );
}
