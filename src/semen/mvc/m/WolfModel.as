package semen.mvc.m{
	import flash.events.EventDispatcher;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class WolfModel extends EventDispatcher {
		private var _positions:Object = {
			'ul': false, 
			'dl': false, 
			'ur': false, 
			'dr': true
		}
		private var _current:String = 'dr';
		public function WolfModel() {
			super();
		}
		
		public function changePosition(pos:String):void {
			for (var posName:String in positions) {
				positions[posName] = Boolean(posName == pos);
			}
			_current = pos;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function flushAll():void {
			_positions= {
				'ul': false, 
				'dl': false, 
				'ur': false, 
				'dr': true
			}
			_current = 'dr';
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function get positions():Object {
			return _positions;
		}
		
		public function get position():String {
			return _current;
		}
	}

}