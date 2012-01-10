package semen.staff {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class RenderEvent extends Event {
		static public const MODEL_CHANGED:String = "modelChanged";
		
		public function RenderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			
		}
		
	}

}