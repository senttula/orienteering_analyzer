import Toybox.Lang;
import Toybox.WatchUi;

class SaveAccelerometerDataDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SaveAccelerometerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}