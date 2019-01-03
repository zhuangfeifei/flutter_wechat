import 'package:flutter/material.dart';

import '../model/found.dart' show Found, FoundItem;

class FoundPage extends StatefulWidget {
  _FoundPageState createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {
  final List<Found> data = FoundItem.mock().founds;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffebebeb),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          var _data = data[index];
          return GestureDetector(
            onTap: (){
              showDialog<Null>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                    return new AlertDialog(
                        title: new Text(_data.title),
                        content: new SingleChildScrollView(
                            child: new ListBody(
                                children: <Widget>[
                                    new Text(_data.title),
                                ],
                            ),
                        ),
                        actions: <Widget>[
                            new FlatButton(
                                child: new Text('确定'),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                            ),
                        ],
                    );
                },
              ).then((val) {
                  print(val);
              });
              print(_data.title);
            },
            child: Container(
              color: Colors.white,
              margin: index == 0 ? const EdgeInsets.only(top: 13.0) : _data.isWidth == 1 ? const EdgeInsets.only(top: 15.0) : null,
              child: Container(
                padding: _data.isWidth == 1 ? const EdgeInsets.fromLTRB(20.0, 13.0, 20.0, 13.0) : const EdgeInsets.fromLTRB(0.0, 13.0, 20.0, 13.0),
                margin: _data.isWidth == 1 ? null : const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xffd9d9d9))
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset(_data.avatar, width: 24.0, height: 24.0,),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text(_data.title),
                    ),
                    Image.asset('assets/images/Mores.png', width: 15.0, height: 15.0,)
                  ],
                ),
              )
            ),
          );
        },
      ),
    );
  }
}