import 'package:flutter/material.dart';

import '../constants.dart' show Constants, AppColors;

import './conversation_page.dart';
import '../contact/contact_page.dart';
import '../found/found_page.dart';
import '../my/my_page.dart';

enum ActionItems {
  GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT
}

class NavigationIconView{
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, IconData icon, IconData activeIcon}) :
    item = BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      title: Text(title),
      backgroundColor: Colors.white
    );
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController  _pageController;
  int _curretIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<Widget> _pages; 

  void initState(){
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '微信',
        icon: IconData(
          0xe602, fontFamily: Constants.IconFontFamily
        ),
        activeIcon: IconData(
          0xe601, fontFamily: Constants.IconFontFamily
        ),
      ),
      NavigationIconView(
        title: '通讯录',
        icon: IconData(
          0xe61c, fontFamily: Constants.IconFontFamily
        ),
        activeIcon: IconData(
          0xe657, fontFamily: Constants.IconFontFamily
        ),
      ),
      NavigationIconView(
        title: '发现',
        icon: IconData(
          0xe64e, fontFamily: Constants.IconFontFamily
        ),
        activeIcon: IconData(
          0xe60f, fontFamily: Constants.IconFontFamily
        ),
      ),
      NavigationIconView(
        title: '我',
        icon: IconData(
          0xe600, fontFamily: Constants.IconFontFamily
        ),
        activeIcon: IconData(
          0xe60a, fontFamily: Constants.IconFontFamily
        ),
      ),
    ];
    _pageController = PageController(initialPage: _curretIndex);
    _pages = [
      ConversationPage(),
      ContactPage(),
      FoundPage(),
      MyPage(),
    ];
  }

  _buildPopupMunItem(int iconName, String title){
    return Row(
      children: <Widget>[
        Icon(IconData(
          iconName, fontFamily: Constants.IconFontFamily
        ), size: 22.0, color: const Color(AppColors.AppBarPopupMenuColor),),
        Container(width: 12.0,),
        Text(title, style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor),),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map((NavigationIconView view){
        return view.item;
      }).toList(),
      currentIndex: _curretIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _curretIndex = index;

          _pageController.animateToPage(_curretIndex,
           duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMunItem(0xe64a, '发起群聊'),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMunItem(0xe638, '添加朋友'),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMunItem(0xe6a2, '扫一扫'),
                  value: ActionItems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMunItem(0xe603, '收付款'),
                  value: ActionItems.PAYMENT,
                ),
              ];
            },
            icon: Icon(Icons.add, size: 30.0,),
            onSelected: (ActionItems selected){ print('点击了$selected'); },
          ),
          SizedBox(width: 16.0,)
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index){
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index){
          setState(() {
            _curretIndex = index;        
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}