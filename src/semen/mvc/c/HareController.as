package semen.mvc.c {
	import semen.staff.Config;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import semen.mvc.m.HareModel;
	import semen.mvc.v.HareView;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class HareController {
		private var _model:HareModel;
		private var _view:HareView;
		private var _timer:Timer;
		
		public function HareController(movie:DisplayObject) {
			_model = new HareModel();
			_view = new HareView(movie, _model);
			_timer = new Timer(Config.hareAppearingInterval);
			_timer.addEventListener(TimerEvent.TIMER, changeHarePresent);
		}
		
		private function changeHarePresent(e:TimerEvent):void {
			_model.reverseVisible();
		}
		
		public function get harePresent():Boolean {
			return _model.isVisible;
		}
		
		public function getReady():void {
			_model.dispatchEvent(new RenderEvent(RenderEvent.MODEL_CHANGED));
		}
		
		public function start():void {
			_timer.start();
		}
		
		public function stopAll():void {
			_timer.stop();
			_timer.reset();
			if (_model.isVisible) _model.reverseVisible();
		}
		
	}

}