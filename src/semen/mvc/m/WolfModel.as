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
			'dr': false,
			'down': false,
			'steady': true
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
		
		public function flushAll(isLose:Boolean = false):void {
			_positions= {
				'ul': false, 
				'dl': false, 
				'ur': false, 
				'dr': false,
				'steady': !isLose,
				'down': isLose
			}
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function getReady():void {
				_positions= {
				'ul': false, 
				'dl': false, 
				'ur': false, 
				'dr': true,
				'steady': false,
				'down': false
			}
			_current = 'dr';
		}
		
		public function get positions():Object {
			return _positions;
		}
		
		public function get position():String {
			return _current;
		}
	}

}