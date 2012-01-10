package semen{
	import semen.staff.Config;
	import semen.mvc.c.RootController;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	
	public class Game extends Background {
		private var counter:Number = 0;
		
		public function Game():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(new Background());
			new RootController(GameField(addChild(new GameField())));
		}
	}
}