import 'package:flutter/material.dart';

import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart' show ConverstaionPageData, Conversation, Device;

// 会话列表
class _ConversationItem extends StatelessWidget {
  final Conversation conversation;

  const _ConversationItem({Key key, this.conversation})
    : assert(conversation != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    // 根据图片的获取方式初始化头像组件
    Widget avatar = conversation.isAvatarFromNet() ? Image.network(conversation.avatar, width: Constants.ConversationAvatarSize, height: Constants.ConversationAvatarSize)
    : Image.asset(conversation.avatar, width: Constants.ConversationAvatarSize, height: Constants.ConversationAvatarSize);

    // 未读消息角标
    Widget unreadMsgCountDotStyle = Container(
      width: Constants.UnreadMsgNotifyDotSize,
      height: Constants.UnreadMsgNotifyDotSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.UnreadMsgNotifyDotSize / 2.0),
        color: Color(AppColors.NotifyDotBg)
      ),
      child: Text(conversation.unreadMsgCount.toString(), style: AppStyles.UnreadMsgCountDotStyle),
    );

    // 头像和未读消息
    Widget avatarContainer = conversation.unreadMsgCount > 0 ? Stack(
      overflow: Overflow.visible,  // 超出显示
      children: <Widget>[
        avatar,
        Positioned(
          right: -6.0, top: -6.0,
          child: unreadMsgCountDotStyle,
        )
      ],
    ) : avatar; 

    // 忽扰模式图标
    var _rightArea = <Widget>[
      Text(conversation.updateAt, style: AppStyles.DesStyle,),
      SizedBox(height: 8.0,),
    ];
    if(conversation.isMute) {
      _rightArea.add(
        Icon(IconData(
          0xe74c, fontFamily: Constants.IconFontFamily,
        ), color: Color(AppColors.ConversationMuteIconSize), size: Constants.ConversationMuteIconSize,);
      );
    }else{
      _rightArea.add(
        Icon(IconData(
          0xe74c, fontFamily: Constants.IconFontFamily,
        ), color: Colors.transparent, size: Constants.ConversationMuteIconSize,);
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItmBg),
        border: Border(bottom: BorderSide(
          color: Color(AppColors.DividerColor), width: Constants.DividerWidth
        ))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          avatarContainer,
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(conversation.title, style: AppStyles.TitleStyle,),
                Text(conversation.des, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppStyles.DesStyle,),
              ],
            ),
          ),
          SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _rightArea
          ),
        ],
      ),
    );
  }
}

// 设备登录
class _DeviceInfoItem extends StatelessWidget {

  final Device device;
  const _DeviceInfoItem({this.device: Device.WIN}) : assert(device != null);

  int get iconName {
    return device == Device.WIN ? 0xe652 : 0xe640;
  }

  String get deviceName {
    return device == Device.WIN ? 'Windows' : 'Mac';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Color(AppColors.DividerColor), width: Constants.DividerWidth
        )),
        color: Color(AppColors.DeviceInfoItemBg)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(
            this.iconName, fontFamily: Constants.IconFontFamily,
          ), size: 24.0, color: Color(AppColors.DeviceInfoItemIcon),),
          SizedBox(width: 16.0,),
          Text('$deviceName 微信已登录，手机通知已关闭。', style: AppStyles.DeviceInfoItemTextStyle),
        ],
      ),
    );
  }
}

// 主页面
class ConversationPage extends StatefulWidget {
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ConverstaionPageData data = ConverstaionPageData.mock();
  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;
    return ListView.builder(
      itemBuilder: (BuildContext contxxt, int index){
        if(data.device != null){
          // 需要显示其它设备的登录信息
          if(index == 0) {
            return _DeviceInfoItem(device: data.device,);
          }
          return _ConversationItem(conversation:  mockConversations[index -1],);
        }
        return _ConversationItem(conversation:  mockConversations[index],);
      },
      itemCount: data.device != null ? mockConversations.length + 1 : mockConversations.length,
    );
  }
}