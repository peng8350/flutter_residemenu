# flutter_residemenu

Residemenu for flutter,android and ios supported


## Usage
1.declare in pubspec.yaml

```

dependencies:
  ...

  residemenu:
    ^1.0.0

```

2.create MenuController to OpenMenu,closeMenu,know if menu is Open,listen the menu callback.

```

MenuController _menuController;

void initState(){
   _menuController = new MenuController(
         listener: new MenuListener(
             onClose: (){

             }
             ,
             onOpen: (bool left){

             }

      )
   );

}

```

3.build() method to create my ResideMenu Widget,child is your contentView(if you use MaterialApp,mostly Scaffold)

```

    new ResideMenu(

            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("images/menu_background.png"),
                    fit: BoxFit.cover)),
            leftView: buildLeft(),
            controller: _menuController,
            child: ...
            )

```

## Table

| Attribute Name     |     Attribute Explain     | Parameter Type | Default Value  | requirement |
|---------|--------------------------|:-----:|:-----:|:-----:|
| child      | your content View   | Widget   |   null |  necessary |
| direction | The direction of allowing ResideMenu to slide     | enum  | left | optional |
| leftView,rightView | the Menu Content View     | Widget  | null | optional |
| elevation |   Content View shadow | double | 12.0 |optional |
| controller | Control menu behavior, get menu status, monitor menu open, close and other events.   | MenuController | null | optional |
| decoration | use to set bg and color in bottom   | BoxDecoration | null | optional |


  final Widget child;

  final ScrollDirection direction;
  //left or right Menu View
  final Widget leftView, rightView;
  //shadow elevation
  final double elevation;
  // it will control the menu Action,such as openMenu,closeMenu
  MenuController controller;
  // used to set bottom bg and color
  final BoxDecoration decoration;