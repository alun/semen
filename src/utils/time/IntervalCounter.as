package utils.time {

import flash.events.EventDispatcher;

public class IntervalCounter extends EventDispatcher {
    protected var
            _intervalTime:int,
            _timeLeft:int;

    public function IntervalCounter(intervalTime:int) {
        _intervalTime = intervalTime;
    }

    public function accelerate(multiplier:Number):void {
        _intervalTime *= 1 - multiplier;
    }
    
    public function passTime(ms:int):void {
        _timeLeft -= ms;
        if (_timeLeft <= 0) {
            _timeLeft = _intervalTime;
            nextIntervalStart();
        }
    }

    protected function nextIntervalStart():void {
        dispatchEvent(new IntervalEvent(IntervalEvent.NEXT_INTERVAL_START));
    }
}
}
