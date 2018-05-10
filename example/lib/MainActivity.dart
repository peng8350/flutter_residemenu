import 'package:flutter/material.dart';
import 'package:residemenu/residemenu.dart';


class MainActivity extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainActivityState();
  }
}

class _MainActivityState extends State<MainActivity> {
  MenuController _menuController;

  Widget buildItem(msg) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              Icons.home,
              color: Colors.white70,
            ),
            new Text(msg, style: new TextStyle(color: Colors.white70))
          ],
        )
        ,
        onTap: () {
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('你点击了$msg')));
        },
      ),
    );
  }

  Widget buildLeft() {
    return new Container(
      margin: new EdgeInsets.only(top: 80.0),
      child: new Column(
        children: <Widget>[
          new CircleAvatar(
            backgroundImage: new AssetImage('images/author.jpeg'),
            radius: 40.0,
          ),
          new Text(
            'Email:peng8350@gmail.com',
            style: new TextStyle(color: Colors.white),
          ),
          new Container(
            width: 200.0,
            child: new ListView(
              physics: new NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemExtent: 50.0,
              children: <Widget>[
                buildItem("菜单一"),
                buildItem("菜单二"),
                buildItem("菜单三"),
                buildItem("菜单四"),
                buildItem("菜单五")
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ResideMenu(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("images/menu_background.png"),
                fit: BoxFit.cover)),
        direction: ScrollDirection.BOTH,
        leftView: buildLeft(),
        rightView: buildLeft(),
        controller: _menuController,
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
                  itemBuilder: (context,index) => new Image.asset("images/menu_background.png",width: 400.0,height: 100.0,fit: BoxFit.cover),
                ),
              )
            ],
          ),
          appBar: new AppBar(
            leading: new GestureDetector(
              child: const Icon(Icons.info),
              onTap: () {
                _menuController.openMenu(true);
              },
            ),
            actions: <Widget>[
              new GestureDetector(
                child: const Icon(Icons.info),
                onTap: () {
                  _menuController.openMenu(false);
                },
              )
            ],
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text('ResideMenu'),
          ),
        ));
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuController = new MenuController(
        listener: new MenuListener(
            onClose: (){
//          print("closed");

            }
            ,
            onOpen: (bool left){
//          print(left);
            }
            ,onOffsetChange: (double offset){
//          print(offset);
        }
        )
    );
  }
}
