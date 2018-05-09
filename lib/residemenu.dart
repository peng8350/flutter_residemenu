/**
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * createTime: 2018-5-9 21:13
 */

library residemenu;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef void OnOpen();
typedef void OnClose();
typedef void OnOffsetChange(double offset);

enum ScrollDirection { left, right }

class ResideMenu extends StatefulWidget {
  final Widget child;

  final ScrollDirection direction;

  final Widget body;

  final MenuListener listener;

  final MenuController controller;

  ResideMenu(
      {@required this.child,
      this.body,
      this.direction,
      this.listener,
      this.controller,
      Key key})
      : assert(child != null),
        super(key: key);

  @override
  _ResideMenuState createState() => new _ResideMenuState();
}

class _ResideMenuState extends State<ResideMenu> {
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, cons) {
      return new Stack(
        children: <Widget>[
          new Container(
            color: const Color(0xffff0000),
            height: cons.biggest.height,
          ),
          widget.child,
        ],
      );
    });
  }
}

class MenuListener {
  final OnOpen onOpen;

  final OnClose onClose;

  final OnOffsetChange onOffsetChange;

  MenuListener({this.onClose, this.onOpen, this.onOffsetChange});
}

class MenuController {
  double offset;

  void openMenu() {}

  void closeMenu() {}
}
