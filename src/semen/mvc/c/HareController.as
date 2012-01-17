package semen.mvc.c {
	import flash.display.MovieClip;
	import flash.events.Event;
	import semen.staff.Config;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import semen.mvc.m.HareModel;
	import semen.mvc.v.HareView;
	import semen.staff.GlobalDispatcher;
	import semen.staff.RenderEvent;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class HareController {
		private var _model:HareModel;
		private var _view:HareView;
		private var _timer:Timer;
		private var _frameTimer:Timer;
		
		public function HareController(movie:MovieClip) {
			_model = new HareModel();
			_view = new HareView(movie, _model);
			_frameTimer = new Timer(500);
			_frameTimer.addEventListener(TimerEvent.TIMER, changeHareState);
			_frameTimer.start();
			_timer = new Timer(Config.hareAppearingInterval,2);
			_timer.addEventListener(TimerEvent.TIMER, changeHarePresent);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, resetTimer);
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.PAUSE, pauseAll);
			GlobalDispatcher.instance.addEventListener(GlobalDispatcher.UNPAUSE, unpauseAll);
			flushAll();
		}
		
		private function changeHareState(e:TimerEvent):void {
			_view.changeHareState();
		}
		
		private function resetTimer(e:TimerEvent):void {
			_timer.stop();
			_timer.reset();
		}
		
		private function pauseAll(e:Event):void {
			_timer.stop();
		}
		
		private function unpauseAll(e:Event):void {
			_timer.start();
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
			if (!_timer.running) {
				_timer.start();
			}
		}
		
		public function flushAll():void {
			_model.flushAll();
			resetTimer(null);
		}		
	}

}