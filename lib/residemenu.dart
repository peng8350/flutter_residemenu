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

  double _startX = 0.0;
  double _width = 0.0;
  bool _isDraging = false;



  void onScrollMove(details){

  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, cons) {
      return new GestureDetector(
        onHorizontalDragStart: (details){
          _startX = details.globalPosition.dx;
          _isDraging = true;
        },
        onHorizontalDragUpdate: (DragUpdateDetails details){
          double offset = details.globalPosition.dx-_startX;
          if(offset<=1.0&&offset<=1.0){

          }
        },
        onHorizontalDragDown: (details){
          _startX = 0.0;
          _isDraging = false;
        },
        child: new Stack(
          children: <Widget>[
            new Container(
              color: const Color(0xffff0000),
              height: cons.biggest.height,
            ),
            widget.child,
          ],
        ),
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

///// Creates a size transition.
/////
///// The [sizeFactor] argument must not be null. The [axis] argument defaults
///// to [Axis.vertical]. The [axisAlignment] defaults to 0.0, which centers the
///// child along the main axis during the transition.
//const SizeTransition({
//Key key,
//this.axis: Axis.vertical,
//@required Animation<double> sizeFactor,
//this.axisAlignment: 0.0,
//this.child,
//}) : assert(axis != null),
//super(key: key, listenable: sizeFactor);
//
///// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise [Axis.vertical].
//final Axis axis;
//
///// The animation that controls the (clipped) size of the child. If the current value
///// of sizeFactor is v then the width or height of the widget will be its intrinsic
///// width or height multiplied by v.
//Animation<double> get sizeFactor => listenable;
//
///// How to align the child along the axis that sizeFactor is modifying.
//final double axisAlignment;
//
///// The widget below this widget in the tree.
/////
///// {@macro flutter.widgets.child}
//final Widget child;
//
//@override
//Widget build(BuildContext context) {
//  AlignmentDirectional alignment;
//  if (axis == Axis.vertical)
//    alignment = new AlignmentDirectional(-1.0, axisAlignment);
//  else
//    alignment = new AlignmentDirectional(axisAlignment, -1.0);
//  return new ClipRect(
//      child: new Align(
//        alignment: alignment,
//        heightFactor: axis == Axis.vertical ? math.max(sizeFactor.value, 0.0) : null,
//        widthFactor: axis == Axis.horizontal ? math.max(sizeFactor.value, 0.0) : null,
//        child: child,
//      )
//  );
//}
//}

class _MenuTransition extends AnimatedBuilder{

  final Animation<double> menuOffset;

  final Widget child;

  final double width;



  _MenuTransition({@required this.child,@required this.menuOffset,Key key,this.width:300.0}):super(key:key);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Matrix4 transform = new Matrix4.identity()
      ..scale(menuOffset.value, menuOffset.value, 1.0);
    return new Positioned(child: new Transform(transform: transform,child: child,),left: menuOffset.value*width*0.8 ,);
  }
}

class MenuController extends ChangeNotifier {
  double offset;

  void openMenu() {}

  void closeMenu() {
  }




}
