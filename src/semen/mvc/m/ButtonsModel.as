package semen.mvc.m {
	import flash.events.EventDispatcher;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	*/
	public class ButtonsModel extends EventDispatcher {
		private var _states:Object = {
			'ul': 'stable',
			'dl': 'stable',
			'ur': 'stable',
			'dr': 'stable'
		}
		private var _last:String = '';
		public function ButtonsModel() {
			super();
		}

		public function down(side:String):void {
			_states[side] = 'down';
			_last = side;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function up(side:String):void {
			side = side ? side : _last;
			_states[side] = 'stable';
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function get states():Object {
			return _states;
		}
	}

}