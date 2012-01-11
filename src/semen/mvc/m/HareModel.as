package semen.mvc.m {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import semen.staff.RenderEvent;
	
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class HareModel extends EventDispatcher {
		private var _isVisible:Boolean;
		
		public function HareModel() {
			_isVisible = false;
		}
		
		public function get isVisible():Boolean {
			return _isVisible;
		}
		
		public function reverseVisible():void {
			_isVisible = !_isVisible;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function flushAll():void {
			_isVisible = false;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		
		
	}

}