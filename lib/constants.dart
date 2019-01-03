import 'package:flutter/material.dart';

class AppColors {
  static const AppBarColor = 0xff303030;
  static const TabIconNormal = 0xff999999;
  static const TabIconActive = 0xff46c11b;
  static const AppBarPopupMenuColor = 0xffffffff;
  static const TItleTextColor = 0xff353535;
  static const ConversationItmBg = 0xffffffff;
  static const DesTextColor = 0xff9e9e9e;
  static const DividerColor = 0xffd9d9d9;
  static const NotifyDotBg = 0xffff3e3e;
  static const NotifyDotText = 0xffffffff;
  static const ConversationMuteIconSize = 0xffd8d8d8;
  static const DeviceInfoItemBg = 0xfff5f5f5;
  static const DeviceInfoItemText = 0xff606062;
  static const DeviceInfoItemIcon = 0xff606062;
}

class AppStyles{
  static const TitleStyle = TextStyle(   // 标题
    fontSize: 14.0,
    color: Color(AppColors.TItleTextColor)
  );

  static const DesStyle = TextStyle(    // 简介              
    fontSize: 12.0,
    color: Color(AppColors.DesTextColor)
  );

  static const UnreadMsgCountDotStyle = TextStyle(   // 未读
    fontSize: 12.0,
    color: Color(AppColors.NotifyDotText)
  );

  static const DeviceInfoItemTextStyle = TextStyle(   // 电脑登录
    fontSize: 13.0,
    color: Color(AppColors.DeviceInfoItemText)
  );
}

class Constants {
  static const IconFontFamily = "appIcoFont";
  static const ConversationAvatarSize = 48.0;  // 头像大小
  static const DividerWidth = 0.5;             // 底部边框
  static const UnreadMsgNotifyDotSize = 20.0;  // 未读消息大小
  static const ConversationMuteIconSize = 20.0;  // 免打扰
}