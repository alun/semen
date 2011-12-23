package utils {

import flash.events.Event;
import flash.events.IEventDispatcher;

/**
 * Utility class to syncronize continuation of calculations
 * on the Array of objects.
 *
 * One this has been set up, it will call callback function
 * only while all object will be released.
 *
 * Objects are get released via release method.
 *
 * There are two helper methods, amed for making a release function with optional event
 * argument, which will release given object.
 *
 * Setting up a release event which will be waited to be fired on each object,
 * and will release the object after the event dispatched.
 */
public class Synchronizer {

	private var waitingObjects : Array = [];
	private var continuation : Function;
	private var _listeners : Array = [];

	/**
	 * Creates a synchronizer on the given array of objects
	 * @param objects array of objects which will be waited to be released
	 * @param continuation continuation function which will be called after all objects will be released
	 */
	public function Synchronizer(objects : Array, continuation : Function) {
		waitingObjects = objects.slice();
		this.continuation = continuation;
		checkWaitingDone();
	}

	/**
	 * Releases the object, and then performs the checking if there are more objects to wait to,
	 * if there are not, it calls the continuation
	 * @param o object to release
	 */
	public function release(o : *) : void {
		var idx : int = waitingObjects.indexOf(o);
		if (idx != -1) {
			waitingObjects.splice(idx, 1);
			checkWaitingDone();
		}
	}

	/**
	 * Makes a helper anonymous function with optional event argument, which will release given
	 * object later when it will be called
	 * @param o object ro release later
	 * @return function to call later to release the object
	 */
	public function makeReleaseFunctionFor(o : *) : Function {
		return function (e : Event = null) : void {
			release(o);
		}
	}

	/**
	 * Setups a listener for each object, which will release the object when it will fire an event
	 * @param eventType the type of event to listen
	 */
	public function useReleaseEvent(eventType : String) : Synchronizer {
		for each (var o : IEventDispatcher in waitingObjects) {
			var ctx : EventContext = EventContext.bind(o, eventType, makeReleaseFunctionFor(o));
			_listeners.push(ctx);
		}
		return this;
	}

	/**
	 * Setups a listener on a given waiting object, which will release the object when it will fire an event
	 * @param object an object to listen
	 * @param eventType an event type to listen
	 */
	public function useReleaseEventFor(object : IEventDispatcher, eventType : String) : Synchronizer {
		if (waitingObjects.indexOf(object) != -1) {
			var ctx : EventContext = EventContext.bind(object, eventType, makeReleaseFunctionFor(object));
			_listeners.push(ctx);
		}
		return this;
	}

	/**
	 * Reset all listeners used by this synchronizer for releasing the objects
	 */
	public function reset() : void {
		for each (var ctx : EventContext in _listeners) {
			ctx.unbind();
		}
		_listeners = [];
	}

	private function checkWaitingDone() : void {
		if (waitingObjects.length == 0) {
			reset();
			safeCall(continuation);
		}
	}

}
}
