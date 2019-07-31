import 'package:flutter/material.dart';
import 'package:residemenu/residemenu.dart';

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainActivityState();
  }
}

class _MainActivityState extends State<MainActivity>
    with TickerProviderStateMixin {
  MenuController _menuController;

  Widget buildItem(String msg1) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
            title: msg1, icon: const Icon(Icons.home, color: Colors.grey)),
        onTap: () {
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text('你点击了$msg1')));
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ResideMenu.scaffold(
      enable3dRotate: true,
      controller: _menuController,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/menu_background.png"),
              fit: BoxFit.none)),
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
          child: new CircleAvatar(
            backgroundImage: new AssetImage('images/author.jpeg'),
            radius: 40.0,
          ),
        ),
        children: <Widget>[
          buildItem("菜单一a"),
          buildItem("菜单二"),
          buildItem("菜单三"),
          buildItem("菜单四"),
          buildItem("菜单五")
        ],
      ),
      rightScaffold: new MenuScaffold(
        header: new CircleAvatar(
          backgroundImage: new AssetImage('images/author.jpeg'),
          radius: 40.0,
        ),
        children: <Widget>[
          buildItem("菜单一"),
          buildItem("菜单二"),
          buildItem("菜单三"),
          buildItem("菜单四"),
          buildItem("菜单五")
        ],
      ),
      child: new Scaffold(
        body: new Column(
          children: <Widget>[
            new Text('水平滚动组件测试'),
            new Container(
              height: 100.0,
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 30,
                itemBuilder: (context, index) => new Image.asset(
                    "images/menu_background.png",
                    width: 400.0,
                    height: 100.0,
                    fit: BoxFit.cover),
              ),
            ),
            WillPopScope(
              child: Expanded(
                child: new ListView(
                  children: <Widget>[
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd'),
                    new Text('sd')
                  ],
                  itemExtent: 150.0,
                ),
              ),
              onWillPop: () async {
                return true;
              },
            )
          ],
        ),
        appBar: new AppBar(
          leading: new GestureDetector(
            child: const Icon(Icons.menu),
            onTap: () {
              _menuController.openMenu(true);
            },
          ),
          actions: <Widget>[
            new GestureDetector(
              child: const Icon(Icons.menu),
              onTap: () {
                _menuController.openMenu(false);
              },
            )
          ],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('ResideMenu'),
        ),
      ),
      onClose: () {
        print("closed");
      },
      onOpen: (left) {
        print(left);
      },
      onOffsetChange: (offset) {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuController =
        new MenuController(vsync: this, direction: ScrollDirection.LEFT);
  }
}
