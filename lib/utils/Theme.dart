import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kSpacingUnit = 10;

bool isDarkTheme = true;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFC0C2C5);
const kAccentColor = Color(0xFF8763B4);//Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
    fontFamily: "SFProText",
    brightness: Brightness.dark,
    primaryColor: kDarkPrimaryColor,
    canvasColor: kDarkPrimaryColor,
    backgroundColor: kDarkSecondaryColor,
    accentColor: kAccentColor,
    iconTheme: ThemeData.dark().iconTheme.copyWith(
      color: kLightSecondaryColor,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: "SFProText",
      bodyColor: kLightSecondaryColor,
      displayColor: kLightSecondaryColor,
    ),
  buttonTheme: const ButtonThemeData(buttonColor: kDarkSecondaryColor)
);

final kLightTheme = ThemeData(
    fontFamily: "SFProText",
    brightness: Brightness.light,
    primaryColor: kLightPrimaryColor,
    canvasColor: kLightPrimaryColor,
    backgroundColor: kLightSecondaryColor,
    accentColor: kAccentColor,
    iconTheme: ThemeData.light().iconTheme.copyWith(
      color: kDarkSecondaryColor,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: "SFProText",
      bodyColor: kDarkSecondaryColor,
      displayColor: kDarkSecondaryColor,
    ),

);