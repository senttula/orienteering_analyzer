import Toybox.Graphics;
import Toybox.WatchUi;

class SaveAccelerometerDataView extends WatchUi.View {

	var mSensorLogger;
	var mTimer;
	var mGPSon;

    function initialize() {
        View.initialize();
        mSensorLogger = new SensorLoggerClass();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        mTimer = View.findDrawableById("timer");
        mGPSon = View.findDrawableById("gps");
    }

    function onShow() as Void {
    	mSensorLogger.onStart();
    }

    function onUpdate(dc as Dc) as Void {
    	//update screen
        mGPSon.setText("timer: " + mSensorLogger.getTimer().toString());
        mTimer.setText("Gps status: \n" + mSensorLogger.getGpsOn());
        
        View.onUpdate(dc);
    }

    function onHide() as Void {
    	mSensorLogger.onStop();
    }

}
