import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.Math;
import Toybox.SensorLogging;
import Toybox.ActivityRecording;
import Toybox.System;
import Toybox.Position;


class SensorLoggerClass {

    var mLogger;
    var mSession;
    var mPositionAccuracy;

    // Constructor
    function initialize() {
        try {
        	mPositionAccuracy = -1;
        	Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
            mLogger = new SensorLogging.SensorLogger({:enableAccelerometer => true, :includePower  => true, :includePitch  => true, :includeRoll  => true});
            mSession = ActivityRecording.createSession({:name=>"SaveAccelerometer", :sport=>ActivityRecording.SPORT_GENERIC, :sensorLogger => mLogger});
        }
        catch(e) {
            System.println(e.getErrorMessage());
        }
    }

    // Callback to receive accel data
    function accel_callback(sensorData) {
        onAccelData();
    }

    function onStart() {
        // initialize accelerometer
        // max sampleRate = 25
        var options = {:period => 1, :sampleRate => 25, :enableAccelerometer => true};
        try {
            Sensor.registerSensorDataListener(method(:accel_callback), options);
            mSession.start();
        }
        catch(e) {
            System.println(e.getErrorMessage());
        }
    }

    function onStop() {
        Sensor.unregisterSensorDataListener();
        mSession.stop();
    }
    
	function onPosition( info as Position.Info ) as Void {
		// show the information of gps accuray
	    mPositionAccuracy = info.accuracy;
	}
	
    // Process new accel data
    function onAccelData() {
        WatchUi.requestUpdate();
    }
    
    // Process new accel data
    function getTimer() {
    	return mLogger.getStats().samplePeriod;
    }
    // Process new accel data
    function getGpsOn() {
    	var gpsStatusString;
    	
    	if(mPositionAccuracy == -1) {
            gpsStatusString = "searching...";
            }
    	else{
    		// Gps accuracy has multiple levels. but we are interested in only has gps been found
    		gpsStatusString = "OK";
    	}

     	return gpsStatusString;
    }
}
