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

class _ResideMenuState extends State<ResideMenu> with TickerProviderStateMixin {
  double _startX = 0.0;
  double _width = 0.0;
  bool _isDraging = false;

  AnimationController _offsetController;

  void _onScrollStart(DragStartDetails details) {
    _startX = details.globalPosition.dx;
    _isDraging = true;
  }

  void _onScrollMove(DragUpdateDetails details) {
    print("move");
    double offset = (details.globalPosition.dx - _startX)/_width*2.0;
    if (offset <= 1.0 && offset >=0.0) {
      _offsetController.value = offset;
    }
  }

  void _onScrollEnd(DragEndDetails details) {
    _startX = 0.0;
    _isDraging = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offsetController = new AnimationController(
         vsync: this, duration: const Duration(microseconds: 200));
    if(widget.controller!=null){
      widget.controller._bind(_offsetController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, cons) {
      _width = cons.biggest.width;
      return new GestureDetector(
        onHorizontalDragStart: _onScrollStart,
        onHorizontalDragUpdate: _onScrollMove,
        onHorizontalDragEnd: _onScrollEnd,
        child: new Stack(
          children: <Widget>[
            new Container(
              color: const Color(0xffff0000),
              height: cons.biggest.height,
            ),
            new _MenuTransition(
                child: widget.child, menuOffset: _offsetController)
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

class _MenuTransition extends AnimatedWidget {
  final Widget child;

  _MenuTransition(
      {@required this.child, @required Animation<double> menuOffset, Key key})
      : super(key: key, listenable: menuOffset);

  Animation<double> get menuOffset => listenable;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new LayoutBuilder(builder: (context, cons) {
      double width = cons.biggest.width;
      double height = cons.biggest.height;
      final Matrix4 transform = new Matrix4.identity()
        ..scale(1.0 - 0.2 * menuOffset.value, 1 - 0.2 * menuOffset.value, 1.0)
        ..translate(menuOffset.value*0.7*width);
      ;
      return new Transform(
          transform: transform,
          child: child,
          origin: new Offset(width, height / 2));
    });
  }
}

class MenuController extends ChangeNotifier {
  AnimationController _animation;

  void openMenu() {
    if(isClose)
    _animation.animateTo(1.0);
  }

  void closeMenu() {
    if(isOpen)
    _animation.animateTo(0.0);
  }

  void _bind(AnimationController animation){
    _animation = animation;
  }

  double get offset => _animation.value;

  bool get isOpen => _animation.value==1.0;

  bool get isClose => _animation.value ==0.0;


}
