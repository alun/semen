package semen.staff{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ButtonEvent extends Event {
		static public const DEACTIVATED:String = "deactivated";
		static public const CLICKED:String = "clicked";
		public var side:String;
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}