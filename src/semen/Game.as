package semen {
import flash.display.Sprite;

import utils.time.IntervalCounter;

public class Game extends Sprite {
    protected var
            _seedGenerateInterval:IntervalCounter,
            _config:Config = new Config();

    public function Game() {
        var configUrl:String = loaderInfo.parameters["configUrl"] || "semen.conf";
        visible = false;
        _config.load(configUrl, onConfigLoaded);
    }

    protected function onConfigLoaded():void {
        trace("Config loaded. Starting the game");
    }
}
}
