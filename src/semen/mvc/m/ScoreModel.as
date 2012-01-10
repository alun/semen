package semen.mvc.m {
	import semen.staff.Config;
	import semen.staff.RenderEvent;
	import semen.staff.State;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class ScoreModel extends EventDispatcher {
		private var _scores:Number = 0;
		private var _fails:Number = 0;
		public function ScoreModel() {
			
		}
		
		public function get scores():Number {
			return _scores;
		}
		
		public function addPoint():void 	{
			_scores++;
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function flushFails():void {
			_fails = 0;
		}
		
		public function get fails():Number {
			return _fails;
		}
		
		public function removeLife(isHare:Boolean):void {
			if (isHare) {
				_fails += .5;
			} else {
				_fails += 1;
			}
			dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function nullAll():void {
			_scores = 0;
			_fails = 0;
		}
	}
}