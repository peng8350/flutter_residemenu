/**
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * createTime: 2018-5-9 21:13
 */

library residemenu;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef void OnOpen(bool isLeft);
typedef void OnClose();
typedef void OnOffsetChange(double offset);

enum ScrollDirection { LEFT, RIGHT, BOTH }

class ResideMenu extends StatefulWidget {
  final Widget child;

  final ScrollDirection direction;

  final Widget leftView, rightView;

  final double elevation;

  MenuController controller;

  ResideMenu(
      {@required this.child,
      this.leftView,
      this.rightView,
      this.direction: ScrollDirection.BOTH,
      this.elevation: 12.0,
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
  //check if user scroll left,or is Right
  bool _isLeft = true;
  // this will controll ContainerAnimation
  AnimationController _offsetController;

  void _onScrollStart(DragStartDetails details) {
    _startX = details.globalPosition.dx;
  }

  void _onScrollMove(DragUpdateDetails details) {
    double offset = (details.globalPosition.dx - _startX) / _width * 2.0;

    _offsetController.value+=offset;
    _startX= details.globalPosition.dx;

    if(_offsetController.value>0.0){
      _changeState(true);
    }
    else{
      _changeState(false);
    }
  }

  void _onScrollEnd(DragEndDetails details) {
    if (_offsetController.value > 0.5 ) {
      widget.controller.openMenu(true);
    }
    else if(_offsetController.value < -0.5){
      widget.controller.openMenu(false);
    }
    else {
      widget.controller.closeMenu();
    }
    _startX = 0.0;
  }

  Widget _buildMenuView() {
    if (_isLeft) {
      return new Align(
        alignment: Alignment.topLeft,
        child: widget.leftView,
      );
    } else {
      return new Align(
        alignment: Alignment.topLeft,
        child: widget.rightView,
      );
    }
  }

  void _changeState(bool left) {
    if (_isLeft != left) {
      setState(() {
        _isLeft = left;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offsetController = new AnimationController(
        lowerBound: widget.direction==ScrollDirection.LEFT?0.0:-1.0,
        upperBound:  widget.direction==ScrollDirection.RIGHT?0.0:1.0,
        value: 0.0,
        vsync: this,
        duration: const Duration(milliseconds: 300));
    if (widget.controller == null) {
      widget.controller = new MenuController();
    }
    widget.controller._bind(_offsetController);
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
              color: _isLeft?const Color(0xffff0000):const Color(0xffffff00),
              height: cons.biggest.height,
              child: _buildMenuView(),
              alignment: _isLeft ? Alignment.topLeft : Alignment.topRight,
            ),
            new GestureDetector(
              onTap: () {
                widget.controller.closeMenu();
              },
              child: new _MenuTransition(
                  child: new Container(
                    child: widget.child,
                    decoration: new BoxDecoration(boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: const Color(0xcc000000),
                        offset: new Offset(-2.0, 2.0),
                        blurRadius: widget.elevation * 0.66,
                      ),
                      new BoxShadow(
                        color: const Color(0x80000000),
                        offset: new Offset(0.0, 3.0),
                        blurRadius: widget.elevation,
                      ),
                    ]),
                  ),
                  menuOffset: _offsetController),
            )
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
        ..scale(1.0 - 0.2 * menuOffset.value.abs(),
            1 - 0.2 * menuOffset.value.abs(), 1.0)
        ..translate(menuOffset.value * 0.8 * width);
      ;
      return new Transform(
          transform: transform,
          child: child,
          origin: new Offset(width / 2, height / 2));
    });
  }
}

class MenuController {
  AnimationController _animation;
  MenuListener listener;
  bool _isOpen = false;

  MenuController({this.listener}) : super();

  void openMenu(left) {
    _animation.animateTo(left ? 1.0 : -1.0);
    if (!isOpened) {
      _isOpen = true;
      if (listener != null) {
        listener.onOpen(left);
      }
    }
  }

  void closeMenu() {
    _animation.animateTo(0.0);
    if (isOpened) {
      _isOpen = false;
      if (listener != null) {
        listener.onClose();
      }
    }
  }

  void _bind(AnimationController animation) {
    _animation = animation;
    _animation.addListener(() {
      if (listener != null) {
        listener.onOffsetChange(_animation.value);
      }
    });
  }

  double get offset => _animation.value;

  bool get isOpened => _isOpen;
}
