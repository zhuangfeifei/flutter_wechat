import 'package:flutter/material.dart';

import '../model/contact.dart' show Contact, ContactsItem;

const LETTER = [
  "↑", "☆",
  "A", "B", "C", "D", "E", "F", "G",
  "H", "I", "J", "K", "L", "M", "N",
  "O", "P", "Q", "R", "S", "T", "U",
  "V", "W", "X", "Y", "Z"
];

class ContactPage extends StatefulWidget {
  Color _color = Colors.transparent;
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final List<Contact> data = ContactsItem.mock().contacts;
  final List<Contact> _data = [];
  final List<_ContactView> _staticView = [
    _ContactView(
      avatar: 'assets/images/ic_new_friend.png',
      name: '新的朋友',
      onPressed: () { print('添加新朋友。'); }
    ),
    _ContactView(
      avatar: 'assets/images/ic_group_chat.png',
      name: '群聊',
      onPressed: () { print('点击了群聊。'); }
    ),
    _ContactView(
      avatar: 'assets/images/ic_tag.png',
      name: '标签',
      onPressed: () { print('标签。'); }
    ),
    _ContactView(
      avatar: 'assets/images/ic_public_account.png',
      name: '公众号',
      onPressed: () { print('添加公众号。'); }
    ),
  ];

  @override
  void initState(){
    super.initState();
    _data..addAll(data)..addAll(data)..addAll(data);
    // 按照字母排序
    _data.sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));
  }

  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints){
    final List<Widget> _letters = LETTER.map((String word){
      return Expanded(
        child: Text(word),
      );
    }).toList();
    return GestureDetector(
      child: Column(
        children: _letters
      ),
      onHorizontalDragDown: (DragDownDetails event){
        setState(() {
          widget._color = Colors.black26;
          print(event);
        });
      },
      onHorizontalDragCancel: (){
        setState(() {
          widget._color = Colors.transparent;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: _data.length + _staticView.length,
            itemBuilder: (BuildContext context, int index){
              if(index < _staticView.length){  // 静态
                return _staticView[index];
              }
              int _index = index - _staticView.length;
              Contact _contact = _data[_index];
              // 判断显示分类  如果与他前一个相同，就隐藏
              bool _isNameIndex = _index > 0 && _data[_index - 1].nameIndex == _contact.nameIndex ? false : true;
              return _ContactView(
                avatar: _contact.avatar, 
                name: _contact.name, 
                nameIndex: _isNameIndex ? _contact.nameIndex : null 
              );
            },            
          ),
        ),
        Positioned(
          width: 30.0, right: 0.0, top: 0.0, bottom: 0.0,
          child: Container(
            color: widget._color,
            child: LayoutBuilder(
              builder: _buildIndexBar,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactView extends StatelessWidget {
  final String avatar;
  final String name;
  final String nameIndex;
  final VoidCallback onPressed;
  _ContactView({this.avatar, this.name, this.nameIndex, this.onPressed});
  
  @override
  Widget build(BuildContext context) {

    // 区分本地图片和网络图片
    Widget _avatars = avatar.startsWith('http') ? Image.network(avatar, width: 36.0, height: 36.0,) 
      : Image.asset(avatar, width: 36.0, height: 36.0,);

    // 判断显示分类
    Widget _nameIndex = nameIndex != null ? Container(
          alignment: Alignment.centerLeft, padding: const EdgeInsets.fromLTRB(16.0, 3.0, 0.0, 3.0),
          color: Color(0xffebebeb),
          child: Text(nameIndex, style: TextStyle(color: Colors.grey)),
        ) : Container();

    return Column(
      children: <Widget>[
        _nameIndex,
        Container(
          margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9))
            )
          ),
          child: Row(
            children: <Widget>[
              _avatars,
              SizedBox(width: 10.0,),
              Text(name),
            ],
          ),
        ),
      ],
    );
  }
}