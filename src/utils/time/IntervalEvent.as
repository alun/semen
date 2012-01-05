package utils.time {

import flash.events.Event;

public class IntervalEvent extends Event {
    public static const NEXT_INTERVAL_START:String = "IntervalEvent.NEXT_INTERVAL_START";

    public function IntervalEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        return new IntervalEvent(type, bubbles, cancelable);
    }
}
}
