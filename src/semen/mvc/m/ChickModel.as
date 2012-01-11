package semen.mvc.m{
	import semen.staff.Config;
	import semen.staff.EggEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ChickModel extends EventDispatcher {
	private var _places:Array = [ false, false, false, false ];
	private var _fall:Array = [ false, false, false, false ];
	private var counter:Number = 0;
		
		public function ChickModel() {
			super();
		}
		
		public function get places():Array {
			return _places.concat();
		}
		
		public function set places(value:Array):void {
			_places = value;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function get fall():Array {
			return _fall;
		}
		
		public function set fall(value:Array):void {
			_fall = value;
		}
		

		
	}

}