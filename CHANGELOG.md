## [1.0.0] - 2018-5-10

* initalRelease

## [1.1.0] - 2018-5-11

* Add ScaleAlpha Effect when open or close

## [1.1.5] - 2018-5-18
* Fix the problem of state loss of the controller
* Add ResideMenuItem and Scfford to constructor Menu
* Provide another way to build MenuView

## [1.1.8] - 2018-5-21
* Fix my igore to limit scroll when Direction == LEFT or RIGHT

## [1.2.0] - 2018-5-22
* Fixed when content View clicks some gestureDector can not be closed.
* Fix itemExtent not used for Scafford

## [1.2.5] - 2018-5-30
* Add enableScale,enableFade option,ScaleAnimation has a proformance problem


## [1.3.1] - 2019-6-3
* Add enable3Drotate
* Remove bottom menuView and bg after closeMenu(improve performance)
* Optimizing internal code

## [1.3.2] - 2019-6-3
* Fix direction not working
* Move direction from ResideMenu to MenuController
* Fix onClose,onOpen callback

## [1.3.3] - 2019-6-4
* Fix decoration bug which invoke rebuild state

## [1.3.5] - 2019-6-5
* Fix init menuController not reference

## [1.3.6]
* enlarge start dx to trigger open remenu distance(if too small,user vertical gesture will open menu too)