package semen {
import com.adobe.serialization.json.JSON;
import com.adobe.serialization.json.JSONParseError;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import utils.EventContext;

public class Config {
    private var
            _wifeAppearFrequency: int = 20000,
            _seedStepInterval:int = 1000,
            _seedGenerationInterval:int = 5000,
            _speedIncrementAfterCaught:int = 10,
            _seedStepIntervalMultiplyPercents:Number = 10,
            _seedGenerationIntervalMultiplyPercents:Number = 10;

    public function get wifeAppearFrequency():int {
        return _wifeAppearFrequency;
    }

    public function get seedStepInterval():int {
        return _seedStepInterval;
    }

    public function get seedGenerationInterval():int {
        return _seedGenerationInterval;
    }

    public function get speedIncrementAfterCaught():int {
        return _speedIncrementAfterCaught;
    }

    public function get seedStepIntervalMultiplyPercents():Number {
        return _seedStepIntervalMultiplyPercents;
    }

    public function get seedGenerationIntervalMultiplyPercents():Number {
        return _seedGenerationIntervalMultiplyPercents;
    }

    /**
     * Loads configuration from the given url
     * @param url URL to load from
     * @param callback callback function to call after load
     */
    public function load(url:String, callback:Function):void {
        var request:URLRequest = new URLRequest(url),
            loader:URLLoader = new URLLoader(),
            successCtx:EventContext, failCtx:EventContext,
            config:Config = this;

        successCtx = EventContext.bindOnce(loader, Event.COMPLETE, function():void {
            try {
                var configObject:Object = JSON.decode(loader.data), field:String;
                for (field in configObject) {
                    config["_" + field] = configObject[field];
                }
            } catch (e:JSONParseError) {
                trace("JSON configuration is not well formed. Using hardcoded config");
                trace(e);
            } catch (e:Error) {
                if (e.errorID == 1056) {
                    trace("Met bad configuration param. Some of others can be set");
                } else {
                    throw(e);
                }
            }
            callback();
        });
        failCtx = EventContext.bindOnce(loader, IOErrorEvent.IO_ERROR, function():void {
            trace("Loading external config '%s' is failed. Using hardcoded config".replace("%s", url));
            callback();
        });
        successCtx.link(failCtx);
        loader.load(request);
    }
}
}
