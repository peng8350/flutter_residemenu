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

  MenuController controller;

  ResideMenu(
      {@required this.child,
      this.body,
      this.direction,
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
  double _offset = 0.0;

  AnimationController _offsetController;

  void _onScrollStart(DragStartDetails details) {
    _startX = details.globalPosition.dx;
  }

  void _onScrollMove(DragUpdateDetails details) {
    _offset = (details.globalPosition.dx - _startX) / _width * 2.0;
    if (_offset >= 0.05) {
      _isDraging = true;
    }
    if (widget.controller.isOpened) {
      _offset = 1.0 + _offset;
    }
    if (_offset >= 0.05) {
      _offsetController.value = _offset;
    }
  }

  void _onScrollEnd(DragEndDetails details) {
    print(_offset);
    if (!_isDraging) return;
    if (_offset > 0.5) {
      widget.controller.openMenu();
    } else {
      widget.controller.closeMenu();
    }
    _startX = 0.0;
    _isDraging = false;
    _offset = 0.0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offsetController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
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
              color: const Color(0xffff0000),
              height: cons.biggest.height,
            ),
            new GestureDetector(
              onTap: () {
                widget.controller.closeMenu();
              },
              child: new _MenuTransition(
                  child: widget.child, menuOffset: _offsetController),
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
        ..scale(1.0 - 0.2 * menuOffset.value, 1 - 0.2 * menuOffset.value, 1.0)
        ..translate(menuOffset.value * 0.7 * width);
      ;
      return new Transform(
          transform: transform,
          child: child,
          origin: new Offset(width, height / 2));
    });
  }
}

class MenuController {
  AnimationController _animation;
  MenuListener listener;
  bool _isOpen = false;


  MenuController({this.listener}):super();

  void openMenu() {
    _animation.animateTo(1.0);
    if (!isOpened) {
      _isOpen = true;
      if (listener != null) {
        listener.onOpen();
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
