/**
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * createTime: 2018-5-9 21:13
 */

library residemenu;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';


class ResideMenu extends StatefulWidget {

  final Widget child;

  ResideMenu({@required this.child,Key key}):assert(child!=null),super(key:key);

  @override
  _ResideMenuState createState() => new _ResideMenuState();
}

class _ResideMenuState extends State<ResideMenu> {


  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context,cons){
      return new Stack(
        children: <Widget>[

          new Container(

            color:const Color(0xffff0000),
            height: cons.biggest.height,
          ),
          widget.child,
        ],
      );
    });
  }
}




