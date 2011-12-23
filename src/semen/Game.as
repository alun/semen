package semen {
import flash.display.Sprite;

public class Game extends Sprite {
    protected var
            _config:Config = new Config(),
            _state:State;

    public function Game() {
        visible = false;
        _config.load("semen.conf", onConfigLoaded);
    }

    protected function onConfigLoaded():void {
        trace("Config loaded. Starting the game");
        _state = new State(_config);
    }
}
}
