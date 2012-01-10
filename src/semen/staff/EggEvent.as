package semen.staff{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class EggEvent extends Event {
		static public const EGG_FALL:String = "eggFall";
		public var side:String;
		public function EggEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			
		}
		
	}

}