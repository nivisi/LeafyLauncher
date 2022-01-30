import 'package:flutter/material.dart';

const kButtonPressForwardAnimationDuration = Duration(milliseconds: 15);
const kButtonPressReverseAnimationDuration = Duration(milliseconds: 100);
const kDefaultAnimationDuration = Duration(milliseconds: 250);
const kDefaultRouteTransitionDuration = Duration(milliseconds: 100);
const kAppRefetchDuration = Duration(minutes: 10);

const kDefaultPadding = 10.0;

const kHomeHorizontalPadding = kDefaultPadding * 2.5;
const kHomeVerticalPadding = kDefaultPadding * 4.0;
const kStatusBarPadding = 20.0;
const kHomeAppsSpacingMultipler = 2.0;
const kHomeHorizontalSwipeIconSize = 55.0;
const kHomeCornerButtonEdgeInsets = EdgeInsets.only(
  left: kDefaultPadding * 1.3,
  right: kDefaultPadding * 1.3,
  bottom: kDefaultPadding,
);
const kHomeSearchOffsetMultipler = 50.0;

const kBarrierColor = Color(0x66000000);

const kUserAppListTopPadding = EdgeInsets.only(top: kDefaultPadding * 7.5);

const kSettingsIcon = Icons.settings;
const kCameraAppIcon = Icons.camera_alt;
const kPhoneAppIcon = Icons.phone;
const kMessagesAppIcon = Icons.message;

const kDefaultAnimationCurve = Curves.fastOutSlowIn;
const kDefaultBorderRadius = BorderRadius.all(Radius.circular(10.0));
