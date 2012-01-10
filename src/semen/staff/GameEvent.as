package semen.staff {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class GameEvent extends Event {
		static public const SPEED_UP:String = "speedUp";
		static public const GAME_OVER:String = "gameOver";
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}