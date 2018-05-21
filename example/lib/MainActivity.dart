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

  Widget buildItem(msg) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: const ResideMenuItem(
            title: "菜单一", icon: const Icon(Icons.home, color: Colors.grey),right: const Icon(Icons.arrow_forward,color:Colors.grey),),
        onTap: () {
          Scaffold
              .of(context)
              .showSnackBar(new SnackBar(content: new Text('你点击了$msg')));
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new ResideMenu.scafford(
      direction: ScrollDirection.RIGHT,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/menu_background.png"),
              fit: BoxFit.cover)),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(

          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
          child: new CircleAvatar(

            backgroundImage: new AssetImage('images/author.jpeg'),
            radius: 40.0,
          ),
        ),
        children: <Widget>[
          buildItem("菜单一"),
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
            new ListView(
              shrinkWrap: true,
              children: <Widget>[
                new Text('sd'),
                new Text('sd'),
                new Text('sd'),
                new Text('sd'),
                new Text('sd')
              ],
              itemExtent: 50.0,
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
//        print("closed");
      },
      onOpen: (left) {
        setState(() {

        });
      },
      onOffsetChange: (offset) {

        setState(() {

        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuController = new MenuController(vsync: this);
  }
}
